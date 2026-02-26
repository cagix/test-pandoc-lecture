-- crawl.lua (Pandoc 3.9)
-- Link-basierter Crawler für lokale .md-Dateien:
-- - dedupliziert (nur erster Fund zählt)
-- - zyklensicher (seen + processed)
-- - baut Verzeichnisbaum mit stabiler Einfüge-Reihenfolge pro Ebene
-- - Titel: Dateien aus YAML title; Ordner aus title des README.md im Ordner (sonst "" + Warnung)
-- - erzeugt summary.md (mdbook-ähnlich), wobei Ordner-Einträge auf ihr README verlinken
-- - erzeugt deps.mk + crawl-order.txt optional
-- - verändert das Pandoc-Ausgabedokument NICHT


--[[
pandoc -L crawl.lua readme.md
]]--


local system = require 'pandoc.system'
local utils  = require 'pandoc.utils'
local path   = require 'pandoc.path'

-- ==========================
-- Konfiguration
-- ==========================
local MAX_FILES = 5000

local README_CANDIDATES = { "README.md", "readme.md" }

-- Artefakte (nil zum Abschalten)
local OUT_SUMMARY_MD = "summary.md"
local OUT_DEPS_MK    = "deps.mk"
local OUT_ORDER_TXT  = "crawl-order.txt"

local MK_VAR_NAME = "COURSE_MD_SOURCES"

-- ==========================
-- Logging (Pandoc API)
-- ==========================
local function warn(msg)
  pandoc.log.warn(msg)
end

local function info(msg)
  -- optional; für ruhigeren Output auskommentieren:
  -- pandoc.log.info(msg)
end

-- ==========================
-- Link/Pfad Utilities
-- ==========================
local function is_remote_target(t)
  if not t or t == "" then return false end
  if t:match("^%a[%w+.-]*:") then return true end -- http:, https:, mailto:, ...
  if t:match("^//") then return true end
  return false
end

local function strip_fragment_and_query(t)
  local s = t:gsub("#.*$", "")
  s = s:gsub("%?.*$", "")
  return s
end

local function file_exists(p)
  local f = io.open(p, "rb")
  if f then f:close(); return true end
  return false
end

local function normalize_md_target(basefile, target)
  if not target or target == "" then return nil end
  if is_remote_target(target) then return nil end

  local clean = strip_fragment_and_query(target)
  if not clean:lower():match("%.md$") then return nil end

  local basedir = path.directory(basefile)
  local joined  = path.join({ basedir, clean })
  return path.normalize(joined)
end

local function split_path(p)
  local parts = {}
  for part in p:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  return parts
end

-- ==========================
-- Pandoc read + Titel (nur Pandoc API, kein pcall)
-- ==========================
local function read_doc(filepath)
  -- nutzt Pandoc intern (kein Subprozess); wir lesen nur den Text ein
  local content = system.read_file(filepath)
  return pandoc.read(content, "markdown")
end

local function get_title_from_doc(doc)
  if not doc or not doc.meta then return nil end
  local t = doc.meta.title
  if not t then return nil end
  local s = utils.stringify(t)
  if s == "" then return nil end
  return s
end

-- ==========================
-- Baumstruktur
-- ==========================
-- dir node:
-- { kind="dir", name="topA", path="lecture/topA", title=nil|"...",
--   readme_path=nil|"lecture/topA/README.md",
--   children={}, child_index={} }
--
-- file node:
-- { kind="file", name="l01.md", path="lecture/topA/l01.md", title=nil|"..."}
local function new_dir_node(name, p)
  return {
    kind = "dir",
    name = name,
    path = p,
    title = nil,
    readme_path = nil,
    children = {},
    child_index = {}
  }
end

local function new_file_node(name, p)
  return {
    kind = "file",
    name = name,
    path = p,
    title = nil
  }
end

local function get_or_add_child_dir(parent, dir_name, dir_path)
  local idx = parent.child_index[dir_name]
  if idx then return parent.children[idx] end
  local n = new_dir_node(dir_name, dir_path)
  table.insert(parent.children, n)
  parent.child_index[dir_name] = #parent.children
  return n
end

local function add_file_leaf(parent, filename, filepath)
  local idx = parent.child_index[filename]
  if idx then return parent.children[idx] end
  local n = new_file_node(filename, filepath)
  table.insert(parent.children, n)
  parent.child_index[filename] = #parent.children
  return n
end

local function ensure_dir_chain(root, filepath)
  local parts = split_path(filepath)
  if #parts == 1 then
    return root, parts[1]
  end

  local dir = root
  local accum = ""
  for i = 1, (#parts - 1) do
    local name = parts[i]
    accum = (accum == "") and name or (accum .. "/" .. name)
    dir = get_or_add_child_dir(dir, name, accum)
  end
  return dir, parts[#parts]
end

-- ==========================
-- Dir README Titel (lazy) + Warnung
-- ==========================
local dir_cache = {} -- dirpath -> { title="", readme_path=nil|... }

local function compute_dir_meta(dirnode)
  local p = dirnode.path
  if p == "" then
    return { title = "Root", readme_path = nil }
  end

  if dir_cache[p] then
    return dir_cache[p]
  end

  local found = nil
  for _, rn in ipairs(README_CANDIDATES) do
    local candidate = path.join({ p, rn })
    if file_exists(candidate) then
      found = candidate
      break
    end
  end

  if not found then
    warn("Ordner ohne README.md: " .. p)
    dir_cache[p] = { title = "", readme_path = nil }
    return dir_cache[p]
  end

  local doc = read_doc(found)
  local t = get_title_from_doc(doc) or ""
  dir_cache[p] = { title = t, readme_path = found }
  return dir_cache[p]
end

local function ensure_dir_meta(dirnode)
  if dirnode.title ~= nil or dirnode.readme_path ~= nil then
    -- Achtung: readme_path kann nil sein; title kann "" sein. Wir prüfen daher:
    if dirnode.title ~= nil then return end
  end
  local m = compute_dir_meta(dirnode)
  dirnode.title = m.title
  dirnode.readme_path = m.readme_path
end

local function ensure_file_title(filenode)
  if filenode.title ~= nil then return end
  local doc = read_doc(filenode.path)
  filenode.title = get_title_from_doc(doc) or ""
end

-- ==========================
-- Link Extraktion
-- ==========================
local function collect_md_links(doc, current_file)
  local found = {}
  doc:walk({
    Link = function(el)
      local norm = normalize_md_target(current_file, el.target)
      if norm then table.insert(found, norm) end
      return el
    end
  })
  return found
end

-- ==========================
-- Crawl
-- ==========================
-- Rückgabe:
-- root: Baum
-- order: Liste der Dateien in Crawl-Reihenfolge (dedupliziert)
local function crawl(startfile)
  local root = new_dir_node("", "")
  root.title = ""         -- wird gleich durch Startfile-Titel gesetzt
  root.readme_path = startfile

  local queue, qh, qt = {}, 1, 0
  local seen = {}       -- entdeckt (in queue)
  local processed = {}  -- abgearbeitet (geparst)

  local order = {}

  local function enqueue(p)
    if not p or p == "" then return end
    if seen[p] then return end
    if not file_exists(p) then
      warn("Linkziel existiert nicht: " .. p)
      return
    end
    seen[p] = true
    qt = qt + 1
    queue[qt] = p
  end

  -- Root-Titel aus der Startdatei
  do
    local startdoc = read_doc(startfile)
    root.title = get_title_from_doc(startdoc) or ""
    -- Startdatei selbst und initiale Links
    enqueue(startfile)
  end

  local count = 0
  while qh <= qt do
    local current = queue[qh]; qh = qh + 1
    if processed[current] then goto continue end
    processed[current] = true

    count = count + 1
    if count > MAX_FILES then
      warn("MAX_FILES erreicht (" .. tostring(MAX_FILES) .. "), Abbruch.")
      break
    end

    -- In Baum einhängen (stabile Ordnung durch first-seen der Dir-Kette + Datei)
    local parent, fname = ensure_dir_chain(root, current)
    local leaf = add_file_leaf(parent, fname, current)
    ensure_file_title(leaf)
    table.insert(order, current)

    -- Dir-Metadaten entlang des Pfads lazy setzen
    do
      local parts = split_path(current)
      local dir = root
      local accum = ""
      for i = 1, (#parts - 1) do
        local name = parts[i]
        accum = (accum == "") and name or (accum .. "/" .. name)
        dir = get_or_add_child_dir(dir, name, accum)
        ensure_dir_meta(dir)
      end
    end

    -- Datei parsen und Links sammeln
    local doc = read_doc(current)
    local links = collect_md_links(doc, current)
    for _, p in ipairs(links) do enqueue(p) end

    ::continue::
  end

  return root, order
end

-- ==========================
-- Emitter: order + deps.mk
-- ==========================
local function emit_order_txt(order)
  if not OUT_ORDER_TXT then return end
  system.write_file(OUT_ORDER_TXT, table.concat(order, "\n") .. "\n")
end

local function emit_deps_mk(order)
  if not OUT_DEPS_MK then return end
  local lines = {}
  table.insert(lines, "# generated by pandoc -L crawl.lua")
  table.insert(lines, MK_VAR_NAME .. " := \\")
  for i, p in ipairs(order) do
    local suffix = (i == #order) and "" or " \\"
    table.insert(lines, "  " .. p .. suffix)
  end
  table.insert(lines, "")
  system.write_file(OUT_DEPS_MK, table.concat(lines, "\n"))
end

-- ==========================
-- Emitter: summary.md
-- Anforderungen:
-- - nur tatsächlich aufgesammelte Links (=> Baum enthält nur aufgesammelte Dateien)
-- - Ordner dienen der Gliederung UND verlinken auf deren README (falls vorhanden)
-- - Gesamttitel = title aus YAML der Startdatei (root.title)
-- ==========================
local function md_escape(s)
  if not s then return "" end
  return s:gsub("\n", " ")
end

local function label_for_file(n)
  if n.title == nil then ensure_file_title(n) end
  return (n.title and n.title ~= "") and n.title or n.name
end

local function label_for_dir(n)
  ensure_dir_meta(n)
  -- Titel darf leer sein; für Anzeige in summary sollten wir dann den Ordnernamen nehmen,
  -- sonst ist die Liste schwer lesbar. Intern bleibt title="" erhalten.
  if n.title and n.title ~= "" then return n.title end
  return n.name
end

local function emit_summary_md(root)
  if not OUT_SUMMARY_MD then return end

  local lines = {}
  local top = root.title or ""
  if top == "" then top = "Summary" end

  table.insert(lines, "# " .. md_escape(top))
  table.insert(lines, "")

  local function rec(node, depth)
    local indent = string.rep("  ", depth)

    if node.kind == "file" then
      local label = md_escape(label_for_file(node))
      table.insert(lines, indent .. "- [" .. label .. "](" .. node.path .. ")")
      return
    end

    -- dir (root nicht als Bullet-Eintrag)
    if node.path ~= "" then
      ensure_dir_meta(node)
      local label = md_escape(label_for_dir(node))
      if node.readme_path then
        table.insert(lines, indent .. "- [" .. label .. "](" .. node.readme_path .. ")")
      else
        -- Kein README: trotzdem Strukturpunkt (nicht klickbar)
        table.insert(lines, indent .. "- " .. label)
      end
      depth = depth + 1
      indent = string.rep("  ", depth)
    end

    for _, ch in ipairs(node.children) do
      rec(ch, depth)
    end
  end

  for _, ch in ipairs(root.children) do
    rec(ch, 0)
  end

  system.write_file(OUT_SUMMARY_MD, table.concat(lines, "\n") .. "\n")
end

-- ==========================
-- Filter Entry Point
-- ==========================
function Pandoc(doc)
  local inputs = PANDOC_STATE and PANDOC_STATE.input_files or nil
  local startfile = (inputs and #inputs >= 1) and inputs[1] or "readme.md"

  info("crawl.lua: start at " .. startfile)

  local tree, order = crawl(startfile)

  emit_order_txt(order)
  emit_deps_mk(order)
  emit_summary_md(tree)

  -- Dokument unverändert
  return doc
end
