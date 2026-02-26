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


-- crawl.lua (Pandoc 3.9+)
-- Link-basierter Crawler für lokale .md-Dateien:
-- - crawlt nur Inline-Links []() (Pandoc AST: Link)
-- - dedupliziert (nur erster Fund zählt)
-- - zyklensicher (seen + processed)
-- - baut Verzeichnisbaum mit stabiler Einfüge-Reihenfolge pro Ebene
-- - Titel: Dateien aus YAML title; Ordner aus title des README.md im Ordner (sonst "" + Warnung)
-- - erzeugt summary.md (mdbook-ähnlich), Ordner-Einträge verlinken auf ihr README (falls vorhanden)
-- - erzeugt deps.mk und optional crawl-order.txt
-- - deps.mk/Dateiliste werden NICHT in Crawl-Reihenfolge ausgegeben, sondern als "baum-flache Liste"
--   in stabiler Reihenfolge je Ebene, mit der Ausgabe-Regel:
--     "erst Dateien, dann Unterordner" (pro Ordner)
-- - bricht bei Parse-Fehlern von Markdown-Dateien mit Fehlermeldung ab (pandoc.error)

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
-- Logging
-- ==========================
local function warn(msg) pandoc.log.warn(msg) end
local function info(msg) -- pandoc.log.info(msg)
end

-- ==========================
-- Utilities
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

  -- Backslashes in Links tolerieren (Windows)
  clean = clean:gsub("\\", "/")

  local basedir = path.directory(basefile)
  local joined  = path.join({ basedir, clean })
  return path.normalize(joined)
end

local function split_path(p)
  local parts = {}
  p = p:gsub("\\", "/")
  for part in p:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  return parts
end

-- ==========================
-- Pandoc read + Titel
-- - bei Fehler: harter Abbruch mit pandoc.error
-- ==========================
local function read_doc(filepath)
  local content = system.read_file(filepath)
  local ok, doc = pcall(pandoc.read, content, "markdown")
  if not ok then
    pandoc.error(
      "Kann Markdown-Datei nicht parsen: " .. filepath
      .. "\nDetails: " .. tostring(doc)
    )
  end
  return doc
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
--   readme_path=nil|".../README.md",
--   children={}, child_index={}, meta_done=false }
--
-- file node:
-- { kind="file", name="l01.md", path="lecture/topA/l01.md", title=nil|"..." }
local function new_dir_node(name, p)
  return {
    kind = "dir",
    name = name,
    path = p,
    title = nil,
    readme_path = nil,
    meta_done = false,
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

-- typisierte Index-Keys vermeiden Kollisionen file vs dir
local function dir_key(name)  return "dir:" .. name end
local function file_key(name) return "file:" .. name end

local function get_or_add_child_dir(parent, dir_name, dir_path)
  local k = dir_key(dir_name)
  local idx = parent.child_index[k]
  if idx then return parent.children[idx] end
  local n = new_dir_node(dir_name, dir_path)
  table.insert(parent.children, n)
  parent.child_index[k] = #parent.children
  return n
end

local function add_file_leaf(parent, filename, filepath)
  local k = file_key(filename)
  local idx = parent.child_index[k]
  if idx then return parent.children[idx] end
  local n = new_file_node(filename, filepath)
  table.insert(parent.children, n)
  parent.child_index[k] = #parent.children
  return n
end

-- Liefert: parent_dirnode, leafname, dirchain (Liste Dirnodes entlang des Pfads)
local function ensure_dir_chain(root, filepath)
  local parts = split_path(filepath)
  if #parts == 1 then
    return root, parts[1], {}
  end

  local dir = root
  local chain = {}
  local accum = ""
  for i = 1, (#parts - 1) do
    local name = parts[i]
    accum = (accum == "") and name or (accum .. "/" .. name)
    dir = get_or_add_child_dir(dir, name, accum)
    table.insert(chain, dir)
  end
  return dir, parts[#parts], chain
end

-- ==========================
-- Dir README Titel (lazy)
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

  local doc = read_doc(found) -- kann hart abbrechen
  local t = get_title_from_doc(doc) or ""
  dir_cache[p] = { title = t, readme_path = found }
  return dir_cache[p]
end

local function ensure_dir_meta(dirnode)
  if dirnode.meta_done then return end
  local m = compute_dir_meta(dirnode)
  dirnode.title = m.title
  dirnode.readme_path = m.readme_path
  dirnode.meta_done = true
end

-- ==========================
-- Link Extraktion (nur Inline-Links)
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
-- crawl_order: Liste der Dateien in Crawl-Reihenfolge (dedupliziert)
local function crawl(startfile)
  local root = new_dir_node("", "")
  root.readme_path = startfile
  root.title = ""

  local queue, qh, qt = {}, 1, 0
  local seen = {}       -- entdeckt (in queue)
  local processed = {}  -- abgearbeitet (geparst)

  local crawl_order = {}

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

  -- Root-Titel aus der Startdatei + Start enqueue
  do
    if not file_exists(startfile) then
      pandoc.error("Startdatei existiert nicht: " .. startfile)
    end
    local startdoc = read_doc(startfile)
    root.title = get_title_from_doc(startdoc) or ""
    enqueue(startfile)
  end

  local count = 0
  while qh <= qt do
    local current = queue[qh]; qh = qh + 1
    if processed[current] then goto continue end
    processed[current] = true

    count = count + 1
    if count > MAX_FILES then
      pandoc.error("MAX_FILES erreicht (" .. tostring(MAX_FILES) .. "), Abbruch.")
    end

    -- Parse current genau einmal: Titel + Links
    local doc = read_doc(current)
    local title = get_title_from_doc(doc) or ""

    -- In Baum einhängen (stabile Ordnung durch first-seen der Dir-Kette + Datei)
    local parent, fname, dirchain = ensure_dir_chain(root, current)
    local leaf = add_file_leaf(parent, fname, current)
    if leaf.title == nil then leaf.title = title end
    table.insert(crawl_order, current)

    -- Dir-Metadaten entlang des Pfads lazy setzen
    for _, d in ipairs(dirchain) do
      ensure_dir_meta(d)
    end

    -- Links sammeln und enqueue in Dokument-Reihenfolge
    local links = collect_md_links(doc, current)
    for _, p in ipairs(links) do enqueue(p) end

    ::continue::
  end

  return root, crawl_order
end

-- ==========================
-- Ausgabe: Baum -> flache Datei-Liste (Themen-/Ordnerbündelung)
-- Regel pro Ordner: "erst Dateien, dann Unterordner"
-- ==========================
local function flatten_tree_files(root)
  local out = {}

  local function rec(node)
    if node.kind == "file" then
      table.insert(out, node.path)
      return
    end

    -- dir: Kinder erst files, dann dirs (jeweils stabil in children-Reihenfolge)
    for _, ch in ipairs(node.children) do
      if ch.kind == "file" then rec(ch) end
    end
    for _, ch in ipairs(node.children) do
      if ch.kind == "dir" then rec(ch) end
    end
  end

  rec(root)
  return out
end

-- ==========================
-- Emitter: crawl order txt (optional, weiterhin Crawl-Reihenfolge)
-- ==========================
local function emit_order_txt(order)
  if not OUT_ORDER_TXT then return end
  system.write_file(OUT_ORDER_TXT, table.concat(order, "\n") .. "\n")
end

-- ==========================
-- Emitter: deps.mk (aus Baum-Reihenfolge, nicht Crawl-Reihenfolge)
-- ==========================
local function emit_deps_mk_from_tree(root)
  if not OUT_DEPS_MK then return end

  local order = flatten_tree_files(root)

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
-- (Ordnerstruktur, Ordner verlinken auf README falls vorhanden)
-- Regel pro Ordner: "erst Dateien, dann Unterordner"
-- ==========================
local function md_escape(s)
  if not s then return "" end
  return s:gsub("\n", " ")
end

local function label_for_file(n)
  return (n.title and n.title ~= "") and n.title or n.name
end

local function label_for_dir(n)
  ensure_dir_meta(n)
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
        table.insert(lines, indent .. "- " .. label)
      end
      depth = depth + 1
      indent = string.rep("  ", depth)
    end

    -- Kinder: erst files, dann dirs
    for _, ch in ipairs(node.children) do
      if ch.kind == "file" then rec(ch, depth) end
    end
    for _, ch in ipairs(node.children) do
      if ch.kind == "dir" then rec(ch, depth) end
    end
  end

  -- root-Kinder: erst files, dann dirs
  for _, ch in ipairs(root.children) do
    if ch.kind == "file" then rec(ch, 0) end
  end
  for _, ch in ipairs(root.children) do
    if ch.kind == "dir" then rec(ch, 0) end
  end

  system.write_file(OUT_SUMMARY_MD, table.concat(lines, "\n") .. "\n")
end

-- ==========================
-- Filter Entry Point
-- ==========================
function Pandoc(doc)
  local inputs = PANDOC_STATE and PANDOC_STATE.input_files or nil
  local startfile = (inputs and #inputs >= 1) and inputs[1] or "readme.md"
  startfile = path.normalize(startfile)

  info("crawl.lua: start at " .. startfile)

  local tree, crawl_order = crawl(startfile)

  -- optional: Crawl-Reihenfolge (BFS, dedupliziert)
  emit_order_txt(crawl_order)

  -- deps.mk in Themen-/Baum-Reihenfolge (Dateien vor Unterordnern)
  emit_deps_mk_from_tree(tree)

  -- summary.md in Themen-/Baum-Reihenfolge (Dateien vor Unterordnern)
  emit_summary_md(tree)

  return doc
end
