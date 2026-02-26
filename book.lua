-- filters/book.lua
-- Aggregiert aus README.md verlinkte .md-Dateien zu einem "Buch", gruppiert nach Unterordnern
-- für mehrere Präfixe (z. B. lecture/, homework/). Kapiteltitel kommen aus H1 des
-- README im jeweiligen Unterordner.
--
-- Konfiguration (empfohlen via --metadata-file book.yml):
-- book:
--   title: "Gesamtskript"
--   demote_by: 1
--   groups:
--     - prefix: "lecture/"
--       level: 1
--     - prefix: "homework/"
--       level: 1
--   readme_names: ["README.md", "readme.md", "_index.md", "index.md"]
--   exclude_readme: true
--
-- Aufrufbeispiele:
--   pandoc README.md -L filters/book.lua --metadata-file book.yml -o build/book.md
--   pandoc README.md -L filters/book.lua --metadata-file book.yml --pdf-engine=tectonic -o build/book.pdf


--[[
# Makefile (Ausschnitt)

PANDOC ?= pandoc
BUILD  ?= build
META   ?= book.yml

# Ihre weiteren Lua-Filter können Sie hier eintragen (Reihenfolge nach book.lua):
OTHER_FILTERS ?= filters/your-filter-1.lua filters/your-filter-2.lua
FILTER_ARGS   := -L filters/book.lua $(addprefix -L ,$(OTHER_FILTERS))

# Gemeinsame Optionen
PANDOC_COMMON := --metadata-file $(META)

# Ziele
$(BUILD):
    mkdir -p $(BUILD)

# Debug: Aggregiertes Markdown (gut zur Kontrolle der Struktur)
$(BUILD)/book.md: README.md filters/book.lua $(META) | $(BUILD)
    $(PANDOC) $< $(FILTER_ARGS) $(PANDOC_COMMON) -o $@

# HTML-Version (leichtgewichtig, z. B. als einfache Webansicht)
$(BUILD)/book.html: README.md filters/book.lua $(META) | $(BUILD)
    $(PANDOC) $< $(FILTER_ARGS) $(PANDOC_COMMON) -t html5 -s -o $@

# PDF mit Tectonic (schneller, schlank)
$(BUILD)/book.pdf: README.md filters/book.lua $(META) | $(BUILD)
    $(PANDOC) $< $(FILTER_ARGS) $(PANDOC_COMMON) --pdf-engine=tectonic -o $@

.PHONY: book book-html book-md
book: $(BUILD)/book.pdf
book-html: $(BUILD)/book.html
book-md: $(BUILD)/book.md
]]--


--[[
# book.yml (Beispiel-Konfiguration)
book:
  title: "Gesamtskript"
  demote_by: 1         # H1 der Einheiten -> H2 (wenn Kapitel H1 sind)
  exclude_readme: true # README-Dateien der Unterordner nicht als Inhalt einbinden
  readme_names: ["README.md", "readme.md", "_index.md", "index.md"]

  # Mehrere Präfixe, die aus dem Haupt-README ausgewertet werden:
  groups:
    - prefix: "lecture/"
      level: 1         # Kapitel-Ebene für lecture/*
    - prefix: "homework/"
      level: 1         # Kapitel-Ebene für homework/*
    # - prefix: "admin/"
    #   level: 1
]]--

local P = pandoc.path or {}
local U = pandoc.utils

local function dirname(p) return (P.directory and P.directory(p)) or (p:match("(.+)/[^/]+$") or ".") end
local function basename(p) return p:gsub("/+$",""):match("([^/]+)$") or p end
local function join(a,b) return (P.join and P.join({a,b})) or (a == "" and b or (a .. "/" .. b)) end
local function norm(p) return (P.normalize and P.normalize(p)) or p end
local function is_abs(target)
  return target:match("^[%a%d]+:") or target:sub(1,1) == '/' or target:sub(1,1) == '#'
end
local function exists(path)
  local f = io.open(path, "r")
  if f then f:close(); return true end
  return false
end
local function read_text(path)
  local f = io.open(path, "r")
  if not f then return nil end
  local s = f:read("*a"); f:close()
  return s
end
local function humanize(s)
  s = s:gsub("_"," "):gsub("-"," ")
  return (s:gsub("^%l", string.upper))
end

local function shift_headings(doc, by)
  if (not by) or by == 0 then return doc end
  return doc:walk{
    Header = function(h)
      h.level = math.min(h.level + by, 6)
      return h
    end
  }
end

local function rewrite_rel_paths(doc, base_dir)
  if not base_dir or base_dir == "" then return doc end
  return doc:walk{
    Link = function(el)
      if el.target and not is_abs(el.target) then
        el.target = norm(join(base_dir, el.target))
      end
      return el
    end,
    Image = function(el)
      local t = el.src or el.target
      if t and not is_abs(t) then
        -- pandoc >= 3 uses el.src, ältere evtl. el.target
        if el.src then
          el.src = norm(join(base_dir, t))
        else
          el.target = norm(join(base_dir, t))
        end
      end
      return el
    end
  }
end

local function first_h1_in_markdown(md)
  local ok, sub = pcall(pandoc.read, md, "markdown")
  if not ok or not sub then return nil end
  for _, b in ipairs(sub.blocks) do
    if b.t == "Header" and b.level == 1 then
      return U.stringify(b.content)
    end
  end
  return nil
end

local function first_h1_in_file(path)
  local md = read_text(path)
  if not md then return nil end
  return first_h1_in_markdown(md)
end

local function collect_md_links(blocks, prefixes, exclude_names)
  local links = {} -- array of { path=..., prefix=... }
  local function has_prefix(path)
    for _, p in ipairs(prefixes) do
      if path:sub(1, #p) == p then return p end
    end
    return nil
  end
  local function is_excluded_name(path)
    local name = basename(path)
    for _, n in ipairs(exclude_names or {}) do
      if name:lower() == n:lower() then return true end
    end
    return false
  end
  local function add(path)
    local clean = (path:match("^[^#?]+") or path)
    if not clean:match("%.md$") then return end
    local pref = has_prefix(clean)
    if not pref then return end
    if is_excluded_name(clean) then return end
    table.insert(links, { path = clean, prefix = pref })
  end
  local function walker(el)
    if el.t == "Link" and el.target then add(el.target) end
    return nil
  end
  pandoc.walk_block(pandoc.Div(blocks), { Link = walker })
  return links
end

local function group_dir_for(path, prefix)
  -- Nimmt den ersten Unterordner unterhalb des Präfixes als Gruppierung, z. B.
  -- lecture/thema2/foo.md -> lecture/thema2
  local rest = path:sub(#prefix + 1)
  local first = rest:match("([^/]+)/")
  if first then
    return (prefix:gsub("/+$","")) .. "/" .. first
  else
    -- Datei liegt direkt unter prefix
    return (prefix:gsub("/+$",""))
  end
end

return {
  {
    Pandoc = function(doc)
      -- Default-Konfig
      local DEMOTE_BY = 1
      local groups_cfg = {} -- array: { prefix=..., level=... }
      local readme_names = { "README.md", "readme.md", "_index.md", "index.md" }
      local exclude_readme = true
      local book_title = nil

      -- Metadaten einlesen
      if doc.meta.book then
        local b = doc.meta.book
        if b.title then book_title = U.stringify(b.title) end
        if b.demote_by then DEMOTE_BY = tonumber(U.stringify(b.demote_by)) or DEMOTE_BY end
        if b.readme_names and b.readme_names.t == "MetaList" then
          readme_names = {}
          for _, v in ipairs(b.readme_names) do table.insert(readme_names, U.stringify(v)) end
        end
        if b.exclude_readme ~= nil then
          exclude_readme = (U.stringify(b.exclude_readme) ~= "false")
        end
        if b.groups and b.groups.t == "MetaList" then
          for _, g in ipairs(b.groups) do
            local mg = g.t == "MetaMap" and g or nil
            if mg and mg["prefix"] then
              local pref = U.stringify(mg["prefix"])
              local lvl = 1
              if mg["level"] then lvl = tonumber(U.stringify(mg["level"])) or 1 end
              table.insert(groups_cfg, { prefix = pref, level = lvl })
            end
          end
        end
      end

      -- Fallback: Einzelpräfix via -M 'book.prefix=...' (optional)
      if (#groups_cfg == 0) and doc.meta["book.prefix"] then
        local pref = U.stringify(doc.meta["book.prefix"])
        local lvl = 1
        if doc.meta["book.level"] then lvl = tonumber(U.stringify(doc.meta["book.level"])) or 1 end
        table.insert(groups_cfg, { prefix = pref, level = lvl })
      end

      if #groups_cfg == 0 then
        -- Nichts konfiguriert: unverändert zurückgeben
        return doc
      end

      -- Liste der Präfixe für die Link-Suche
      local prefixes = {}
      for _, g in ipairs(groups_cfg) do table.insert(prefixes, g.prefix) end

      -- Links aus dem Eingangs-README sammeln
      local raw_links = collect_md_links(doc.blocks, prefixes, exclude_readme and readme_names or {})

      if #raw_links == 0 then
        return doc -- keine passenden Links: Original belassen
      end

      -- Map für schnellen Zugriff auf Prefix->Level
      local prefix_level = {}
      for _, g in ipairs(groups_cfg) do prefix_level[g.prefix] = g.level or 1 end

      -- Gruppierung aufbauen
      local groups = {} -- key: group_dir -> { level=..., prefix=..., files = {}, title=nil }
      local order = {}  -- Reihenfolge der ersten Erwähnung
      local seen_group = {}
      local seen_in_group = {}

      for _, L in ipairs(raw_links) do
        local path, pref = L.path, L.prefix
        local gdir = group_dir_for(path, pref)
        if not groups[gdir] then
          groups[gdir] = { level = prefix_level[pref] or 1, prefix = pref, files = {} }
          seen_in_group[gdir] = {}
        end
        if not seen_group[gdir] then
          table.insert(order, gdir); seen_group[gdir] = true
        end
        if not seen_in_group[gdir][path] then
          table.insert(groups[gdir].files, path)
          seen_in_group[gdir][path] = true
        end
      end

      -- Ausgabe-Dokument zusammenbauen
      local out = {}

      if book_title and #book_title > 0 then
        table.insert(out, pandoc.Header(1, pandoc.Str(book_title)))
      end

      for _, gdir in ipairs(order) do
        local g = groups[gdir]
        -- Kapitel-Titel aus README im Unterordner ermitteln
        local title = nil
        for _, cand in ipairs(readme_names) do
          local p = join(gdir, cand)
          if exists(p) then
            title = first_h1_in_file(p)
            if title and #title > 0 then break end
          end
        end
        if not title or #title == 0 then
          title = humanize(basename(gdir))
        end

        table.insert(out, pandoc.Header(g.level, pandoc.Str(title)))

        -- Inhalte der verlinkten Dateien einfügen
        for _, file in ipairs(g.files) do
          local md = read_text(file)
          if not md then
            table.insert(out, pandoc.Para{ pandoc.Str("Warnung: Datei nicht gefunden: " .. file) })
          else
            local ok, sub = pcall(pandoc.read, md, "markdown")
            if not ok or not sub then
              table.insert(out, pandoc.Para{ pandoc.Str("Warnung: Datei nicht lesbar: " .. file) })
            else
              sub = shift_headings(sub, DEMOTE_BY)
              sub = rewrite_rel_paths(sub, dirname(file))
              for _, b in ipairs(sub.blocks) do table.insert(out, b) end
            end
          end
        end
      end

      doc.blocks = out
      return doc
    end
  }
}
