
--[[
pandoc SUMMARY.md \
  -L filters/book.lua \
  -M book.summary_dir=. \
  -M book.assets_dir=build/book-assets \
  -M book.assets_rel=book-assets \
  -M book.max_list_depth=3 \
  -t gfm -o build/book.md

pandoc build/book.md -o build/book.pdf --pdf-engine=tectonic


book.yaml:

book:
  summary_dir: "."
  assets_dir: "build/book-assets"
  assets_rel: "book-assets"
  syllabus_title: "Syllabus"
  max_list_depth: 3
  drop_root_title_header: true
  drop_root_title_header: "always"

pandoc SUMMARY.md -L filters/book.lua --metadata-file book.yml -t gfm -o build/book.md
]]--



-- filters/book.lua
-- SUMMARY.md (BulletList) -> Gesamtbuch (Pandoc Markdown)
-- - Titel aus YAML title der Root-Datei (erstes SUMMARY-Item)
-- - Einleitung: H1 "Syllabus" + Root-Inhalt (um +1 demoted)
-- - Weitere Items: Heading-Level = listDepth (1->H1, 2->H2, ...)
-- - Inhalte demoted um header_level
-- - Generiert stabile, globale Header-IDs (werden in Pandoc Markdown i. d. R. als {#id} ausgegeben)
-- - Mappt Links other.md#frag -> #global-id (Alias-Strategie), other.md -> #chap-...
-- - Kopiert Bilder in assets_dir und rewritet Pfade (GitHub/docsify geeignet)
-- - Optional: book.drop_root_title_header = true|"always"
--   entfernt im Root (nach Demotion) das erste H2, wenn es dem YAML-Titel entspricht (oder immer)
-- - Strict: Fehler -> error()

local P = pandoc.path or {}
local U = pandoc.utils

-- ---------- basic helpers ----------
local function norm(p) return (P.normalize and P.normalize(p)) or p end
local function join(a, b)
  return (P.join and P.join({ a, b })) or (a == "" and b or (a .. "/" .. b))
end
local function dirname(p)
  return (P.directory and P.directory(p)) or (p:match("(.+)/[^/]+$") or ".")
end
local function is_abs(t)
  return t:match("^[%a%d]+:") or t:sub(1, 1) == "/" or t:sub(1, 1) == "#"
end

local function read_text(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local s = f:read("*a"); f:close()
  return s
end

local function file_exists(path)
  local f = io.open(path, "rb")
  if f then f:close(); return true end
  return false
end

local function ensure_dir(path)
  if P.make_directory then
    P.make_directory(path, true)
  else
    os.execute(string.format('mkdir -p "%s"', path))
  end
end

local function copy_file(src, dst)
  local fin = io.open(src, "rb")
  if not fin then error("Kann Datei nicht öffnen: " .. src) end
  local data = fin:read("*a"); fin:close()
  ensure_dir(dirname(dst))
  local fout = io.open(dst, "wb")
  if not fout then error("Kann Datei nicht schreiben: " .. dst) end
  fout:write(data); fout:close()
end

local function slugify(s)
  s = (s or ""):lower()
  s = s:gsub("%s+", "-")
  s = s:gsub("[^%w%-_]", "")
  s = s:gsub("%-+", "-")
  s = s:gsub("^%-", ""):gsub("%-$", "")
  if s == "" then s = "x" end
  return s
end

local function github_slug(s)
  -- grob GitHub-ähnlich: lower, spaces->-, drop non-alnum except -, collapse -
  s = (s or ""):lower()
  s = s:gsub("[%s]+", "-")
  s = s:gsub("[^%w%-]", "")
  s = s:gsub("%-+", "-")
  s = s:gsub("^%-", ""):gsub("%-$", "")
  if s == "" then s = "x" end
  return s
end

local function hash8(s)
  local h = 2166136261
  for i = 1, #s do
    h = (h ~ s:byte(i)) * 16777619
    h = h % 2 ^ 32
  end
  return string.format("%08x", h)
end

local function shift_headings(doc, by)
  if not by or by == 0 then return doc end
  return doc:walk {
    Header = function(h)
      h.level = math.min(h.level + by, 6)
      return h
    end
  }
end

local function max(a, b) if a > b then return a else return b end end

local function to_global_id(file_path, local_id)
  return "h-" .. slugify(local_id) .. "-" .. hash8(file_path)
end

-- ---------- optional root title header drop ----------
local function normalize_title(s)
  s = (s or ""):lower()
  s = s:gsub("%s+", " ")
  s = s:gsub("^%s+", ""):gsub("%s+$", "")
  s = s:gsub("[%p]", "")
  return s
end

local function drop_first_root_h2_if_matches_title(blocks, doc_title, mode)
  if not blocks or #blocks == 0 then return blocks end
  local want_always = (mode == "always")

  for i, b in ipairs(blocks) do
    if b.t == "Header" then
      if b.level == 2 then
        if want_always then
          table.remove(blocks, i)
        else
          local htxt = U.stringify(b.content)
          if normalize_title(htxt) == normalize_title(doc_title) then
            table.remove(blocks, i)
          end
        end
      end
      break -- only consider first header in root
    end
  end
  return blocks
end

-- ---------- parse SUMMARY.md bullet list ----------
-- returns ordered items {title, path, listDepth}
local function parse_summary(doc, summary_dir)
  local items = {}

  local function first_link_in_blocks(blocks)
    for _, blk in ipairs(blocks) do
      if blk.t == "Para" or blk.t == "Plain" then
        for _, inl in ipairs(blk.content) do
          if inl.t == "Link" then return inl end
        end
      end
    end
    return nil
  end

  local function walk_list(list, depth)
    for _, item in ipairs(list) do
      local lnk = first_link_in_blocks(item)
      if lnk and lnk.target and lnk.target:match("%.md") and not is_abs(lnk.target) then
        local clean = (lnk.target:match("^[^#?]+") or lnk.target)
        table.insert(items, {
          title = U.stringify(lnk.content),
          path = norm(join(summary_dir, clean)),
          listDepth = depth
        })
      end
      for _, blk in ipairs(item) do
        if blk.t == "BulletList" then
          walk_list(blk.content, depth + 1)
        end
      end
    end
  end

  for _, b in ipairs(doc.blocks) do
    if b.t == "BulletList" then walk_list(b.content, 0) end
  end

  return items
end

-- ---------- header alias collection ----------
-- aliases[frag] = global_id
local function collect_header_aliases(subdoc, file_path)
  local aliases = {}
  subdoc:walk {
    Header = function(h)
      local text = U.stringify(h.content)
      local explicit = h.identifier

      local s1 = slugify(text)
      local s2 = github_slug(text)

      local base = (explicit and explicit ~= "") and explicit or s1
      local gid = to_global_id(file_path, base)

      local candidates = {}
      if explicit and explicit ~= "" then table.insert(candidates, explicit) end
      if s1 and s1 ~= "" then table.insert(candidates, s1) end
      if s2 and s2 ~= "" then table.insert(candidates, s2) end

      for _, c in ipairs(candidates) do
        if not aliases[c] then aliases[c] = gid end
      end
      return nil
    end
  }
  return aliases
end

-- ---------- rewrite doc (headers/links/images) ----------
local function rewrite_doc(subdoc, base_dir, ctx)
  return subdoc:walk {
    Header = function(h)
      local text = U.stringify(h.content)
      local explicit = h.identifier
      local local_key = (explicit and explicit ~= "") and explicit or slugify(text)

      local aliases = ctx.header_aliases_by_file[ctx.current_file] or {}
      local gid = aliases[local_key] or to_global_id(ctx.current_file, local_key)

      h.identifier = gid
      return h
    end,

    Link = function(el)
      if not el.target or is_abs(el.target) then return el end

      local raw = el.target:gsub("%?.*$", "")
      local file_part, frag = raw, nil
      local before, after = raw:match("^([^#]+)#(.+)$")
      if before then file_part, frag = before, after end

      if file_part:match("%.md$") then
        local abs = norm(join(base_dir, file_part))
        local chap_anchor = ctx.chapter_anchor_by_file[abs]
        if chap_anchor then
          if frag and frag ~= "" then
            local aliases = ctx.header_aliases_by_file[abs] or {}
            local mapped = aliases[frag] or aliases[slugify(frag)] or aliases[github_slug(frag)]
            if mapped then
              el.target = "#" .. mapped
            else
              el.target = "#" .. chap_anchor
              local k = abs .. "#" .. frag
              if not ctx.unresolved[k] then
                io.stderr:write("Warnung: Unaufgelöster Link-Anker: " .. k .. "\n")
                ctx.unresolved[k] = true
              end
            end
          else
            el.target = "#" .. chap_anchor
          end
          return el
        end

        -- target md file not in book: keep normalized
        el.target = norm(join(base_dir, el.target))
        return el
      end

      -- non-md relative
      el.target = norm(join(base_dir, el.target))
      return el
    end,

    Image = function(el)
      local t = el.src or el.target
      if not t or is_abs(t) then return el end

      local clean = (t:match("^[^#?]+") or t)
      local abs = norm(join(base_dir, clean))
      if not file_exists(abs) then
        error("Bilddatei nicht gefunden: " .. abs .. " (referenziert aus " .. ctx.current_file .. ")")
      end

      local ext = abs:match("(%.[%w]+)$") or ""
      local safe = slugify(abs:gsub(ext .. "$", "")):sub(-70)
      local out_name = safe .. "-" .. hash8(abs) .. ext
      local out_path = norm(join(ctx.assets_dir, out_name))

      if not ctx.assets_seen[abs] then
        copy_file(abs, out_path)
        ctx.assets_seen[abs] = true
      end

      local rel = norm(join(ctx.assets_rel, out_name))
      if el.src then el.src = rel else el.target = rel end
      return el
    end
  }
end

-- ---------- main filter ----------
return {
  {
    Pandoc = function(doc)
      local cfg = doc.meta.book or {}

      local summary_dir = cfg.summary_dir and U.stringify(cfg.summary_dir) or "."
      local assets_dir  = cfg.assets_dir  and U.stringify(cfg.assets_dir)  or "build/book-assets"
      local assets_rel  = cfg.assets_rel  and U.stringify(cfg.assets_rel)  or "book-assets"
      local syllabus_title = cfg.syllabus_title and U.stringify(cfg.syllabus_title) or "Syllabus"
      local max_list_depth = cfg.max_list_depth and tonumber(U.stringify(cfg.max_list_depth)) or 3

      local drop_root_title_header = false -- false | true | "always"
      if cfg.drop_root_title_header ~= nil then
        local v = U.stringify(cfg.drop_root_title_header)
        if v == "true" then drop_root_title_header = true
        elseif v == "always" then drop_root_title_header = "always"
        else drop_root_title_header = false end
      end

      ensure_dir(assets_dir)

      local items = parse_summary(doc, summary_dir)
      if #items == 0 then error("SUMMARY.md: keine Bullet-Links auf .md-Dateien gefunden.") end

      local root = items[1]
      if root.listDepth ~= 0 then
        error("SUMMARY.md: erster Eintrag muss listDepth=0 (oberster Bulletpoint) sein.")
      end

      for _, it in ipairs(items) do
        if not file_exists(it.path) then
          error("Markdown-Datei nicht gefunden: " .. it.path)
        end
        if it.listDepth > max_list_depth then
          io.stderr:write(
            "Warnung: Große SUMMARY-Tiefe (" .. it.listDepth ..
            " > " .. max_list_depth .. "): " .. it.path .. "\n"
          )
        end
      end

      -- Root lesen: YAML title übernehmen
      local root_md = assert(read_text(root.path), "Kann Root nicht lesen: " .. root.path)
      local root_doc = pandoc.read(root_md, "markdown")
      if root_doc.meta and root_doc.meta.title then
        doc.meta.title = root_doc.meta.title
      else
        error("Root-Readme hat kein YAML-Metadatum 'title': " .. root.path)
      end

      -- Anchors per file (links to file without #frag)
      local chapter_anchor_by_file = {}
      for _, it in ipairs(items) do
        chapter_anchor_by_file[it.path] = "chap-" .. slugify(it.title) .. "-" .. hash8(it.path)
      end

      -- Pass 1: collect header aliases for all files (for .md#frag mapping)
      local header_aliases_by_file = {}
      for _, it in ipairs(items) do
        local md = assert(read_text(it.path), "Kann Datei nicht lesen: " .. it.path)
        local sub = pandoc.read(md, "markdown")
        header_aliases_by_file[it.path] = collect_header_aliases(sub, it.path)
      end

      -- Build output
      local ctx = {
        assets_dir = assets_dir,
        assets_rel = assets_rel,
        assets_seen = {},
        chapter_anchor_by_file = chapter_anchor_by_file,
        header_aliases_by_file = header_aliases_by_file,
        current_file = nil,
        unresolved = {},
      }

      local out = {}

      -- H1 Syllabus + Root content (demoted +1)
      table.insert(out, pandoc.Header(1, pandoc.Str(syllabus_title), pandoc.Attr("syllabus-" .. hash8(root.path))))

      ctx.current_file = root.path
      root_doc = shift_headings(root_doc, 1)

      if drop_root_title_header then
        local doc_title_str = U.stringify(doc.meta.title)
        local mode = (drop_root_title_header == "always") and "always" or "match"
        root_doc.blocks = drop_first_root_h2_if_matches_title(root_doc.blocks, doc_title_str, mode)
      end

      root_doc = rewrite_doc(root_doc, dirname(root.path), ctx)
      for _, b in ipairs(root_doc.blocks) do table.insert(out, b) end

      -- Remaining items: wrapper heading level = listDepth (1->H1 topics, 2->H2 sessions ...)
      for i = 2, #items do
        local it = items[i]
        ctx.current_file = it.path

        local header_level = math.min(max(1, it.listDepth), 6)
        local chap_id = chapter_anchor_by_file[it.path]
        table.insert(out, pandoc.Header(header_level, pandoc.Str(it.title), pandoc.Attr(chap_id)))

        local md = assert(read_text(it.path), "Kann Datei nicht lesen: " .. it.path)
        local sub = pandoc.read(md, "markdown")

        -- content under wrapper heading
        sub = shift_headings(sub, header_level)

        sub = rewrite_doc(sub, dirname(it.path), ctx)
        for _, b in ipairs(sub.blocks) do table.insert(out, b) end
      end

      doc.blocks = out
      return doc
    end
  }
}
