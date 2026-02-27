-- crawl.lua (Pandoc 3.9+)
--
-- Link-basierter Crawler für lokale .md-Dateien:
-- - crawlt nur Inline-Links []() (Pandoc AST: Link)
-- - dedupliziert (nur erster Fund zählt)
-- - zyklensicher (seen + processed)
-- - baut Verzeichnisbaum mit stabiler Einfüge-Reihenfolge pro Ebene
-- - Titel: Dateien aus YAML title
-- - Ordner-Titel: aus YAML title der README.md im jeweiligen Ordner (sonst "" + Warnung)
-- - erzeugt:
--     summary.md (mdbook-ähnlich; pro Ebene: zuerst Dateien, dann Ordner;
--                 Ordner-Einträge verlinken auf ihr README, falls vorhanden)
--     deps.mk (Make-Variable mit Quellenliste, in Baum-Reihenfolge)
--     crawl-order.txt (optional, BFS/Crawl-Reihenfolge)
-- - verändert das Pandoc-Ausgabedokument NICHT
--
-- Aufruf:
--   pandoc -L crawl.lua readme.md -t plain --wrap=none

local system = require 'pandoc.system'
local utils  = require 'pandoc.utils'
local path   = require 'pandoc.path'

-- ==========================
-- Konfiguration
-- ==========================
local MAX_FILES = 5000

local README_CANDIDATES = { "readme.md", "README.md" }

-- Artefakte (nil zum Abschalten)
local OUT_SUMMARY_MD = "summary.md"
local OUT_DEPS_MK    = "deps.mk"
local OUT_ORDER_TXT  = "crawl-order.txt"

local MK_VAR_NAME = "COURSE_MD_SOURCES"

-- Optional: Root als Bullet in summary.md ausgeben (Link auf Startdatei)
-- - false: erster Bullet-Punkt "- [<root-title>](<startfile>)"
-- - true : erster Bullet-Punkt "- [<ROOT_README_LABEL>](<startfile>)"
local SUMMARY_INCLUDE_ROOT_BULLET = true
local ROOT_README_LABEL = "Syllabus"

-- ==========================
-- Logging
-- ==========================
local function warn(msg) pandoc.log.warn(msg) end
local function info(_msg)
  -- pandoc.log.info(_msg)
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

-- Eigene Normalisierung für relative Pfade:
-- - ersetzt "\" durch "/"
-- - entfernt "."-Segmente
-- - wertet ".." aus, soweit möglich (ohne über den Anfang hinaus zu gehen)
local function normalize_relpath(p)
  if not p or p == "" then return p end

  -- erst mal Pandoc normalisieren lassen (Trenner usw.)
  p = path.normalize(p)

  -- jetzt unsere eigene Segment-Logik für "." und ".."
  local parts = {}
  for part in p:gmatch("[^/]+") do
    if part == "." or part == "" then
      -- überspringen
    elseif part == ".." then
      if #parts > 0 and parts[#parts] ~= ".." then
        table.remove(parts)
      else
        table.insert(parts, "..")
      end
    else
      table.insert(parts, part)
    end
  end

  local res = table.concat(parts, "/")
  if res == "" then
    return "."
  end
  return res
end

-- Normalize local markdown link target:
-- - ignore remote targets
-- - ignore non-.md targets
-- - resolve relative targets against basefile directory
local function normalize_md_target(basefile, target)
  if not target or target == "" then return nil end
  if is_remote_target(target) then return nil end

  local clean = strip_fragment_and_query(target)
  if not clean:lower():match("%.md$") then return nil end

  -- tolerate Windows-style separators in links
  clean = clean:gsub("\\", "/")

  -- Normalize basefile zuerst, um konsistente Pfadauflösung sicherzustellen
  basefile = normalize_relpath(basefile)
  local basedir = path.directory(basefile)
  local joined  = path.join({ basedir, clean })

  -- Relativen Zielpfad an basedir anhängen und dann ".." usw. auflösen
  local joined = (basedir == "." or basedir == "") and clean or (basedir .. "/" .. clean)

  return normalize_relpath(joined)
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
-- Pandoc read + Title
-- - on error: hard abort with pandoc.error
-- ==========================
local function read_doc(filepath)
  local ok_read, content = pcall(system.read_file, filepath)
  if not ok_read then
    pandoc.error(
      "Kann Datei nicht lesen: " .. filepath
      .. "\nDetails: " .. tostring(content)
    )
  end

  local ok_parse, doc = pcall(pandoc.read, content, "markdown")
  if not ok_parse then
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
-- Tree structure
-- ==========================
-- dir node:
-- { kind="dir", name="topA", path="lecture/topA",
--   title=nil|"...", readme_path=nil|"../README.md",
--   meta_done=false,
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
    meta_done = false,
    children = {},
    child_index = {},
  }
end

local function new_file_node(name, p)
  return {
    kind = "file",
    name = name,
    path = p,
    title = nil,
  }
end

-- typed keys to avoid collisions between file and dir nodes with same name
local function dir_key(name)  return "dir:" .. name end
local function file_key(name) return "file:" .. name end

local function rebuild_child_index(dirnode)
  dirnode.child_index = {}
  for i, ch in ipairs(dirnode.children) do
    local k = (ch.kind == "file") and file_key(ch.name) or dir_key(ch.name)
    dirnode.child_index[k] = i
  end
end

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

-- Ensure that all directory nodes along filepath exist.
-- Returns: parent_dirnode, leafname, dirchain (list of dirnodes on path)
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
-- Dir README title (lazy) + cache
-- ==========================
local dir_cache = {} -- dirpath -> { title="", readme_path=nil|... }

local function compute_dir_meta(dirnode)
  local p = dirnode.path

  -- Root: use what crawler sets; do not auto-generate "Root"
  if p == "" then
    return { title = dirnode.title or "", readme_path = dirnode.readme_path }
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

  -- README parsen, Titel holen
  local doc = read_doc(found)
  local t = get_title_from_doc(doc) or ""

  -- README als File-Node im Verzeichnisbaum sicherstellen und nach vorne setzen
  do
    -- Dateiname extrahieren (z.B. "readme.md")
    local fname = path.filename and path.filename(found) or found:match("([^/]+)$")
    if not fname then fname = found end

    -- 1. Versuchen, einen existierenden Knoten mit genau diesem Namen zu finden
    local k = file_key(fname)
    local idx = dirnode.child_index[k]

    -- 2. Falls nicht gefunden: case-insensitive suchen (wichtig auf macOS)
    if not idx then
      local fname_lower = fname:lower()
      for i, ch in ipairs(dirnode.children) do
        if ch.kind == "file" and ch.name:lower() == fname_lower then
          idx = i
          break
        end
      end
    end

    local readme_node

    if idx then
      -- Knoten existiert bereits (ggf. mit anderer Groß-/Kleinschreibung):
      readme_node = dirnode.children[idx]

      -- An erste Stelle verschieben, falls nötig
      if idx ~= 1 then
        table.remove(dirnode.children, idx)
        table.insert(dirnode.children, 1, readme_node)
      end

      -- Falls der Name (Repräsentation) abweicht, können Sie sich entscheiden:
      -- a) erste gefundene Schreibweise beibehalten (nichts tun)
      -- b) oder auf 'fname' umstellen:
      -- readme_node.name = fname
      -- readme_node.path = found
    else
      -- neuen File-Node an Position 1 einfügen
      readme_node = new_file_node(fname, found)
      table.insert(dirnode.children, 1, readme_node)
    end

    -- Titel auf dem Datei-Knoten setzen, falls noch leer
    if not readme_node.title or readme_node.title == "" then
      readme_node.title = t
    end

    -- child_index aktualisieren
    rebuild_child_index(dirnode)
  end

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
-- Iteration helper:
-- "files first, then dirs", stable within each group
-- ==========================
local function for_children_files_then_dirs(node, fn)
  for _, ch in ipairs(node.children) do
    if ch.kind == "file" then fn(ch) end
  end
  for _, ch in ipairs(node.children) do
    if ch.kind == "dir" then fn(ch) end
  end
end

-- ==========================
-- Link extraction (inline links only)
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
-- Crawl (BFS)
-- Returns:
--   root: tree
--   crawl_order: list of files in BFS crawl order (deduplicated)
-- ==========================
local function crawl(startfile)
  local root = new_dir_node("", "")
  root.readme_path = startfile  -- model root as "points to startfile"
  root.title = ""               -- will be set from startfile YAML title

  local queue, qh, qt = {}, 1, 0
  local seen = {}       -- discovered/enqueued
  local processed = {}  -- already parsed/processed

  local crawl_order = {}

  local function enqueue(p)
    if not p or p == "" then return end
    -- Kanonische Form des Pfads verwenden
    p = normalize_relpath(p)
    if seen[p] then return end

    if not file_exists(p) then
      warn("Linkziel existiert nicht: " .. p)
      return
    end

    seen[p] = true
    qt = qt + 1
    queue[qt] = p
  end

  -- Startpfad kanonisieren
  startfile = normalize_relpath(startfile)
  root.readme_path = startfile

  -- Initialize root title from startfile + enqueue startfile
  if not file_exists(startfile) then
    pandoc.error("Startdatei existiert nicht: " .. startfile)
  end

  do
    local startdoc = read_doc(startfile)
    root.title = get_title_from_doc(startdoc) or ""
    enqueue(startfile)
  end

  local count = 0
  while qh <= qt do
    local current = queue[qh]
    qh = qh + 1

    if not processed[current] then
      processed[current] = true

      count = count + 1
      if count > MAX_FILES then
        pandoc.error("MAX_FILES erreicht (" .. tostring(MAX_FILES) .. "), Abbruch.")
      end

      -- Parse current exactly once: title + links
      local doc = read_doc(current)
      local title = get_title_from_doc(doc) or ""

      -- Attach to tree (stable insertion by first-seen)
      local parent, fname, dirchain = ensure_dir_chain(root, current)
      local leaf = add_file_leaf(parent, fname, current)
      if leaf.title == nil then leaf.title = title end

      table.insert(crawl_order, current)

      -- Ensure directory metadata along the path (lazy, but done during crawl)
      for _, d in ipairs(dirchain) do
        ensure_dir_meta(d)
      end

      -- NEW: Verzeichnis-READMEs entlang des Pfads ebenfalls crawlen
      for _, d in ipairs(dirchain) do
        if d.readme_path then
          enqueue(d.readme_path)
        end
      end

      -- Collect links and enqueue in document order
      local links = collect_md_links(doc, current)
      for _, p in ipairs(links) do
        enqueue(p)
      end
    end
  end

  return root, crawl_order
end

-- ==========================
-- Output: tree -> flat file list (topic/directory grouping)
-- Rule per directory: "files first, then subdirs"
-- ==========================
local function flatten_tree_files(root)
  local out = {}

  local function rec(node)
    if node.kind == "file" then
      table.insert(out, node.path)
      return
    end

    for_children_files_then_dirs(node, function(ch)
      rec(ch)
    end)
  end

  rec(root)
  return out
end

-- ==========================
-- Emitter: crawl-order.txt (optional; BFS crawl order)
-- ==========================
local function emit_order_txt(order)
  if not OUT_ORDER_TXT then return end
  system.write_file(OUT_ORDER_TXT, table.concat(order, "\n") .. "\n")
end

-- ==========================
-- Emitter: deps.mk (tree order, NOT crawl order)
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
-- Emitter: Dep-Liste als Pandoc-Dokument (für $(shell ...) in Make)
--[[
## Markdown sources: einmalig beim Parsen bestimmen
COURSE_MD_SOURCES := $(shell \
  $(PANDOC_MIN) \
    -L $(PANDOC_DATA)/crawl.lua \
    -M prefix=$(OUTPUT_DIR) \
    -f markdown -t plain --wrap=none \
    $(ROOT_MD) \
)
]]--
-- ==========================
local function emit_deps_doc_from_tree(root, meta)
  local order = flatten_tree_files(root)

  local inlines = {}
  for i, p in ipairs(order) do
    if i > 1 then
      table.insert(inlines, pandoc.Space())
    end
    table.insert(inlines, pandoc.Str(p))
  end

  local blocks = { pandoc.Plain(inlines) }
  return pandoc.Pandoc(blocks, meta or pandoc.Meta{})
end

-- ==========================
-- Emitter: summary.md
-- - directory structure
-- - per level: files first, then dirs (stable within each)
-- - directory entries link to README if present
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

  -- Ensure root meta is consistent (root.readme_path already set in crawl)
  ensure_dir_meta(root)

  local lines = {}
  local top = root.title or ""
  if top == "" then top = "Summary" end

  table.insert(lines, "# " .. md_escape(top))
  table.insert(lines, "")

  -- Optional: Root as first bullet item linking to startfile
  if SUMMARY_INCLUDE_ROOT_BULLET and root.readme_path then
    local root_label = ROOT_README_LABEL or top
    table.insert(lines, "- [" .. md_escape(root_label) .. "](" .. root.readme_path .. ")")
  end

  local function rec(node, depth)
    local indent = string.rep("  ", depth)

    if node.kind == "file" then
      local label = md_escape(label_for_file(node))
      table.insert(lines, indent .. "- [" .. label .. "](" .. node.path .. ")")
      return
    end

    -- directory node (root itself is not emitted here as a directory bullet)
    if node.path ~= "" then
      local label = md_escape(label_for_dir(node))
      if node.readme_path then
        table.insert(lines, indent .. "- [" .. label .. "](" .. node.readme_path .. ")")
      else
        table.insert(lines, indent .. "- " .. label)
      end
      depth = depth + 1
    end

    -- children: files first, then dirs
    for_children_files_then_dirs(node, function(ch)
      -- README-Datei nicht als Kind ausgeben, wenn der Verzeichniseintrag
      -- bereits auf node.readme_path verlinkt
      if node.readme_path
         and ch.kind == "file"
         and ch.path == node.readme_path then
        return
      end
      rec(ch, depth)
    end)
  end

  -- Emit children of root (root is header; optionally also a bullet above)
  for_children_files_then_dirs(root, function(ch)
    -- Root-README nicht doppelt ausgeben, wenn wir schon eine Bullet dafür erzeugen
    if SUMMARY_INCLUDE_ROOT_BULLET
       and root.readme_path
       and ch.kind == "file"
       and ch.path == root.readme_path then
      return
    end
    rec(ch, 0)
  end)

  system.write_file(OUT_SUMMARY_MD, table.concat(lines, "\n") .. "\n")
end

-- ==========================
-- Filter Entry Point
-- ==========================
function Pandoc(doc)
  local inputs = PANDOC_STATE and PANDOC_STATE.input_files or nil
  local startfile = (inputs and #inputs >= 1) and inputs[1] or "readme.md"
  startfile = normalize_relpath(startfile)

  info("crawl.lua: start at " .. startfile)

  -- Crawl und Baum aufbauen
  local tree, crawl_order = crawl(startfile)

  -- Immer diese drei Artefakte schreiben
  emit_order_txt(crawl_order)
  emit_deps_mk_from_tree(tree)
  emit_summary_md(tree)

  -- Als Pandoc-Ausgabe immer: Dokument mit leerzeichengetrennter Dateiliste
  return emit_deps_doc_from_tree(tree, doc.meta)
end
