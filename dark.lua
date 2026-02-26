-- filters/assets-darkmode.lua


--[[
GFM:
pandoc path/to/wuppie.md \
  -o build/path/to/wuppie.md \
  --lua-filter=filters/assets-darkmode.lua \
  -M outdir=build

Docsify-this:
pandoc path/to/wuppie.md \
  -o build/path/to/wuppie.md \
  --lua-filter=filters/assets-darkmode.lua \
  -M outdir=build \
  -M asset_base=https://raw.githubusercontent.com/ORG/REPO/docsify/
]]--


-- filters/assets-darkmode.lua  (Pandoc 3.9)
--
-- Plattformneutral (Windows/macOS/Linux), ein Pandoc-Lauf.
--
-- Aufgaben:
-- - Bildpfade aus Markdown (lokal, relativ zur Eingabe-MD) erkennen
-- - benötigte Bilder nach build_root/<pfad-der-md>/... kopieren (Spiegelung)
-- - zusätzlich Dark-Mode-Variante via ImageMagick 7 ("magick") erzeugen
-- - im Output-Markdown: <picture> mit prefers-color-scheme: dark ausgeben
-- - optional: asset_base setzen, um src/srcset als absolute URLs auszugeben
--   (hilfreich für docsify-this, um inkonsistentes Rewriting zu umgehen)
--
-- Pandoc-Aufrufe:
--   # GFM/offline (relative URLs)
--   pandoc path/to/wuppie.md -o build/path/to/wuppie.md \
--     --lua-filter=filters/assets-darkmode.lua \
--     -M build_root=build
--
--   # docsify-this (absolute URLs über RawGitHub)
--   pandoc path/to/wuppie.md -o build/path/to/wuppie.md \
--     --lua-filter=filters/assets-darkmode.lua \
--     -M build_root=build \
--     -M asset_base=https://raw.githubusercontent.com/ORG/REPO/docsify/

-- filters/assets-darkmode.lua (Pandoc 3.9)

-- filters/assets-darkmode.lua  (Pandoc 3.9)
--
-- Zweck:
-- - findet AST-Images (Markdown-Syntax ![]())
-- - kopiert lokale, relative Bilder in eine Spiegelstruktur unterhalb outdir/build_root
-- - wenn ImageMagick ("magick") vorhanden: erzeugt invertierte Dark-Variante
-- - ersetzt Images durch <picture> für light/dark (GitHub-Preview: relative Pfade;
--   docsify-this: asset_base => absolute URLs)
-- - behandelt Pandoc-Markdown Figures ebenfalls (Caption bleibt sichtbar)
--
-- CLI:
--   pandoc path/to/wuppie.md -o build/path/to/wuppie.md \
--     --lua-filter=filters/assets-darkmode.lua -M outdir=build
--
--   pandoc path/to/wuppie.md -o build/path/to/wuppie.md \
--     --lua-filter=filters/assets-darkmode.lua -M outdir=build \
--     -M asset_base=https://raw.githubusercontent.com/ORG/REPO/docsify/

local sys  = require("pandoc.system")
local path = require("pandoc.path")

local BUILD_ROOT = nil
local ASSET_BASE = nil

local seen = {}
local MAGICK_OK = nil

-- ---------- helpers ----------

local function input_file()
  local inputs = PANDOC_STATE.input_files
  if inputs and #inputs > 0 then return inputs[1] end
  return nil
end

local function warn(img_src, msg)
  pandoc.log.warn(string.format(
    "[assets-darkmode] %s: %s: %s",
    input_file() or "<stdin>", img_src or "<no-src>", msg
  ))
end

local function mkdir_p(dir)
  if dir and dir ~= "" then sys.make_directory(dir, true) end
end

local function ensure_trailing_slash(u)
  if not u or u == "" then return u end
  if u:match("/$") then return u end
  return u .. "/"
end

local function is_windows_abs(p)
  return p:match("^[A-Za-z]:[\\/]")
end

local function has_parent_traversal(p)
  return p:match("(^|/)%..(/|$)") or p:match("(^|\\\)%.%.(\\|$)")
end

local function html_attr_escape(s)
  if s == nil then return "" end
  s = tostring(s)
  return (s:gsub("&", "&")
           :gsub("<", "<")
           :gsub(">", ">")
           :gsub('"', """))
end

local function url_encode_path(p)
  -- Keep "/" unescaped; encode outside unreserved set
  return (p:gsub("([^%w%-%_%.%~/%])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function urlify(rel)
  rel = path.normalize(rel):gsub("^/+", "")
  if ASSET_BASE and ASSET_BASE ~= "" then
    return ASSET_BASE .. url_encode_path(rel)
  end
  return rel -- GitHub case: keep relative paths as-is
end

local function have_magick()
  if MAGICK_OK ~= nil then return MAGICK_OK end

  -- Missing IM is not an error: catch only here.
  MAGICK_OK = pcall(function()
    pandoc.pipe("magick", {"-version"}, "")
  end)

  return MAGICK_OK
end

local function make_dark(src_abs, dst_abs)
  if path.exists(dst_abs) then return end

  mkdir_p(path.directory(dst_abs))

  -- If magick exists but conversion fails, abort (real error).
  local res = sys.command("magick", {
    src_abs,
    "-colorspace", "sRGB",
    "-modulate", "80,110,100",
    "-contrast-stretch", "2%x1%",
    dst_abs
  })

  if type(res) == "table" and res.code and res.code ~= 0 then
    error("[assets-darkmode] ImageMagick-Konvertierung fehlgeschlagen (Exitcode "
      .. tostring(res.code) .. "): " .. src_abs)
  end
end

local function join_classes(classes)
  if not classes or #classes == 0 then return nil end
  return table.concat(classes, " ")
end

local function img_html_attrs_from_pandoc(img)
  -- Map Pandoc Image attributes to HTML attributes for <img>.
  local id_attr = ""
  if img.attr and img.attr.identifier and img.attr.identifier ~= "" then
    id_attr = ' id="' .. html_attr_escape(img.attr.identifier) .. '"'
  end

  local class_attr = ""
  local cls = img.attr and join_classes(img.attr.classes) or nil
  if cls and cls ~= "" then
    class_attr = ' class="' .. html_attr_escape(cls) .. '"'
  end

  local attrs = (img.attr and img.attr.attributes) or {}

  local styles = {}

  -- width/height: use CSS to support % values reliably
  if attrs.width and attrs.width ~= "" then
    table.insert(styles, "width:" .. attrs.width)
    if not attrs.height or attrs.height == "" then
      table.insert(styles, "height:auto")
    end
  end
  if attrs.height and attrs.height ~= "" then
    table.insert(styles, "height:" .. attrs.height)
    if not attrs.width or attrs.width == "" then
      table.insert(styles, "width:auto")
    end
  end

  -- append explicit style=
  if attrs.style and attrs.style ~= "" then
    table.insert(styles, attrs.style:gsub("^%s*", ""):gsub("%s*$", ""))
  end

  local style_attr = ""
  if #styles > 0 then
    style_attr = ' style="' .. html_attr_escape(table.concat(styles, ";")) .. '"'
  end

  -- forward only data-* and aria-* (safe subset)
  local other = {}
  for k, v in pairs(attrs) do
    if k ~= "width" and k ~= "height" and k ~= "style" then
      if k:match("^data%-.+") or k:match("^aria%-.+") then
        table.insert(other, string.format(' %s="%s"', html_attr_escape(k), html_attr_escape(v)))
      end
    end
  end

  return id_attr, class_attr, style_attr, table.concat(other)
end

local function picture_html_string(img, normal_rel, dark_rel)
  local alt = html_attr_escape(img.alt and pandoc.utils.stringify(img.alt) or "")
  local title = img.title and pandoc.utils.stringify(img.title) or ""
  local title_attr = (title ~= "") and (' title="' .. html_attr_escape(title) .. '"') or ""

  local id_attr, class_attr, style_attr, other_attr = img_html_attrs_from_pandoc(img)

  local normal_url = urlify(normal_rel)
  local dark_url   = urlify(dark_rel)

  -- note: title only on <img>, not on <source>
  return string.format([\\[ <picture>
  <source media="(prefers-color-scheme: dark)" srcset="%s" />
  <img src="%s" alt="%s"%s%s%s%s%s />
</picture>]],
    dark_url,
    normal_url,
    alt,
    title_attr,
    id_attr, class_attr, style_attr,
    other_attr
  )
end

local function picture_inline(img, normal_rel, dark_rel)
  return pandoc.RawInline("html", picture_html_string(img, normal_rel, dark_rel))
end

local function picture_block(img, normal_rel, dark_rel)
  return pandoc.RawBlock("html", picture_html_string(img, normal_rel, dark_rel))
end

local function render_caption_to_html(caption)
  -- Pandoc Figure caption shape in 3.x: usually caption.long (Blocks)
  if not caption then return "" end

  if caption.long and #caption.long > 0 then
    return pandoc.write(pandoc.Pandoc(caption.long), "html")
  end

  -- fallback: sometimes caption.content as Inlines
  if caption.content and #caption.content > 0 then
    local doc = pandoc.Pandoc({ pandoc.Para(caption.content) })
    local html = pandoc.write(doc, "html")
    html = html:gsub("^%s*<p>", ""):gsub("</p>%s*$", "")
    return html
  end

  return ""
end

-- Central image processing: copy (always), dark (only if magick), return element
local function process_image(img, want_block)
  local src = img.src
  if not src or src == "" then return img end

  -- remote/data: leave unchanged, do not copy
  if src:match("^https?://") or src:match("^data:") then
    return img
  end

  -- hardening: abort on unexpected path forms
  if src:match("^/") or is_windows_abs(src) then
    error("[assets-darkmode] Absoluter Bildpfad ist nicht erlaubt: " .. src)
  end
  local src_norm = path.normalize(src)
  if has_parent_traversal(src_norm) then
    error("[assets-darkmode] Bildpfad mit '..' ist nicht erlaubt: " .. src)
  end

  local infile = input_file()
  if not infile then
    error("[assets-darkmode] Kein Input-Dateiname bekannt (Pandoc stdin?). Kann Bildpfade nicht relativ auflösen: " .. src)
  end

  local in_dir = path.directory(infile) or "."
  local src_abs = path.normalize(path.join({ in_dir, src_norm }))

  if not path.exists(src_abs) then
    error("[assets-darkmode] Bilddatei nicht gefunden: " .. src .. " (erwartet: " .. src_abs .. ")")
  end

  local outdir = path.normalize(path.join({ BUILD_ROOT, in_dir }))

  -- Keep structure: the link path stays the same relative to output markdown
  local normal_rel = src_norm:gsub("^/+", "")
  local normal_abs = path.normalize(path.join({ outdir, normal_rel }))

  local dir_part, base = path.split(normal_rel)
  local ext = (base:match("(%.[^%.]+)$") or ""):lower()
  local stem = base:gsub("%.[^%.]+$", "")

  -- copy once per source file (per pandoc run)
  if not seen[src_abs] then
    seen[src_abs] = true
    if not path.exists(normal_abs) then
      mkdir_p(path.directory(normal_abs))
      sys.copy_file(src_abs, normal_abs) -- aborts on real copy errors
    end
  end

  -- never convert svg, and if IM missing: keep markdown image (but we did copy)
  if ext == ".svg" or (not have_magick()) then
    img.src = normal_rel
    return img
  end

  local dark_base = stem .. ".dark" .. ext
  local dark_rel  = path.normalize(path.join({ dir_part, dark_base }))
  local dark_abs  = path.normalize(path.join({ outdir, dark_rel }))

  make_dark(src_abs, dark_abs)

  if want_block then
    return picture_block(img, normal_rel, dark_rel)
  else
    return picture_inline(img, normal_rel, dark_rel)
  end
end

-- ---------- pandoc callbacks ----------

function Meta(meta)
  local outdir = nil
  if meta.outdir then outdir = pandoc.utils.stringify(meta.outdir) end
  if (not outdir or outdir == "") and meta.build_root then
    outdir = pandoc.utils.stringify(meta.build_root)
  end
  if not outdir or outdir == "" then
    error("[assets-darkmode] Bitte -M outdir=... setzen (oder -M build_root=...).")
  end
  BUILD_ROOT = outdir

  if meta.asset_base then
    ASSET_BASE = ensure_trailing_slash(pandoc.utils.stringify(meta.asset_base))
  end

  if not have_magick() then
    warn(nil, "ImageMagick ('magick') nicht gefunden. Keine Dark-Mode-Bilder; Assets werden nur kopiert, AST-Images bleiben unverändert.")
  end

  return meta
end

function Image(img)
  return process_image(img, false)
end

function Figure(fig)
  -- Ensure copying (and picture conversion if available) happens for the first image
  -- inside the figure, but keep figure caption.
  local replaced = false
  local new_content = pandoc.walk_block(pandoc.Div(fig.content), {
    Image = function(img)
      if replaced then
        -- still ensure copying if you ever have multiple images in one figure
        return process_image(img, false)
      end
      replaced = true
      return process_image(img, true) -- picture as block inside figure
    end
  }).content

  -- If IM not available, process_image returns normal Image; in that case we can
  -- just keep the figure unchanged by returning nil (no change).
  -- BUT we already did the copying work via process_image; returning nil keeps AST.
  if not have_magick() then
    return nil
  end

  -- If IM available, we render the whole figure to HTML with <figure>/<figcaption>
  local caption_html = render_caption_to_html(fig.caption)
  caption_html = caption_html:gsub("^%s*", ""):gsub("%s*$", "")

  local id_attr = ""
  local class_attr = ""
  if fig.attr and fig.attr.identifier and fig.attr.identifier ~= "" then
    id_attr = ' id="' .. html_attr_escape(fig.attr.identifier) .. '"'
  end
  if fig.attr and fig.attr.classes and #fig.attr.classes > 0 then
    class_attr = ' class="' .. html_attr_escape(table.concat(fig.attr.classes, " ")) .. '"'
  end

  local inner_html = pandoc.write(pandoc.Pandoc(new_content), "html")
  inner_html = inner_html:gsub("^%s*", ""):gsub("%s*$", "")

  local figcaption = ""
  if caption_html ~= "" then
    figcaption = "<figcaption>\n" .. caption_html .. "\n</figcaption>"
  end

  local html = string.format("<figure%s%s>\n%s\n%s\n</figure>",
    id_attr, class_attr, inner_html, figcaption)

  return pandoc.RawBlock("html", html)
end
