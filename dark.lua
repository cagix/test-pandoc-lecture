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
  return "<unknown input>"
end

local function warn(img_src, msg)
  pandoc.log.warn(string.format("[assets-darkmode] %s: %s: %s", input_file(), img_src, msg))
end

local function mkdir_p(dir)
  if dir and dir ~= "" then
    sys.make_directory(dir, true)
  end
end

local function ensure_trailing_slash(u)
  if not u or u == "" then return u end
  if u:match("/$") then return u end
  return u .. "/"
end

local function urlify(rel)
  -- Normalize .. and . (and keep paths consistent)
  rel = path.normalize(rel)

  -- avoid accidental absolute paths in URLs
  rel = rel:gsub("^/+", "")

  if ASSET_BASE and ASSET_BASE ~= "" then
    return ASSET_BASE .. rel
  end
  return rel
end

local function have_magick()
  if MAGICK_OK ~= nil then return MAGICK_OK end
  MAGICK_OK = pcall(function()
    pandoc.pipe("magick", {"-version"}, "")
  end)
  return MAGICK_OK
end

local function make_dark(src_abs, dst_abs, img_src_for_log)
  if path.exists(dst_abs) then return true end
  mkdir_p(path.directory(dst_abs))

  local ok, err = pcall(function()
    pandoc.pipe("magick", {
      src_abs,
      "-colorspace", "sRGB",
      "-modulate", "80,110,100",
      "-contrast-stretch", "2%x1%",
      dst_abs
    }, "")
  end)

  if not ok then
    warn(img_src_for_log, "ImageMagick-Konvertierung fehlgeschlagen (" .. tostring(err) .. ").")
    return false
  end
  return true
end

local function picture_html(alt, normal_rel, dark_rel, title)
  local a = (alt and alt ~= "") and alt or ""
  local t = (title and title ~= "") and pandoc.utils.stringify(title) or ""
  local title_attr = (t ~= "") and (' title="' .. t:gsub('"','"') .. '"') or ""

  local normal_url = urlify(normal_rel)
  local dark_url   = urlify(dark_rel)

  local html = string.format([\\[ <picture>
  <source media="(prefers-color-scheme: dark)" srcset="%s"%s />
  <img src="%s" alt="%s"%s />
</picture>]], dark_url, title_attr, normal_url, a:gsub('"','"'), title_attr)

  return pandoc.RawInline("html", html)
end

-- ---------- pandoc callbacks ----------
function Meta(meta)
  if meta.build_root then
    BUILD_ROOT = pandoc.utils.stringify(meta.build_root)
  end
  if not BUILD_ROOT or BUILD_ROOT == "" then
    error("Bitte -M build_root=... setzen (z.B. build).")
  end

  if meta.asset_base then
    ASSET_BASE = ensure_trailing_slash(pandoc.utils.stringify(meta.asset_base))
  end

  if not have_magick() then
    pandoc.log.warn("[assets-darkmode] ImageMagick ('magick') nicht gefunden. Keine Dark-Mode-Bilder; Bilder bleiben normale Markdown-Images.")
  end

  return meta
end

function Image(img)
  local src = img.src

  -- remote/data: leave unchanged
  if src:match("^https?://") or src:match("^data:") then
    return img
  end

  -- resolve source path relative to the input markdown file
  local infile = input_file()
  local in_dir = (infile ~= "<unknown input>") and path.directory(infile) or "."
  local src_abs = path.normalize(path.join({in_dir, src}))

  if not path.exists(src_abs) then
    warn(src, "Datei nicht gefunden (erwartet: " .. src_abs .. ").")
    return img
  end

  -- output directory mirrors the input directory under BUILD_ROOT
  local outdir = path.normalize(path.join({BUILD_ROOT, in_dir}))

  -- keep structure: relative path stays relative in the output markdown
  local normal_rel = path.normalize(src):gsub("^/+", "")
  local normal_abs = path.normalize(path.join({outdir, normal_rel}))

  local dir_part, base = path.split(normal_rel)
  local ext = (base:match("(%.[^%.]+)$") or ""):lower()
  local stem = base:gsub("%.[^%.]+$", "")

  local dark_base = stem .. ".dark" .. ext
  local dark_rel = path.normalize(path.join({dir_part, dark_base}))
  local dark_abs = path.normalize(path.join({outdir, dark_rel}))

  -- copy once per source file
  if not seen[src_abs] then
    seen[src_abs] = true
    if not path.exists(normal_abs) then
      mkdir_p(path.directory(normal_abs))
      sys.copy_file(src_abs, normal_abs)
    end
  end

  -- SVG: do not convert; keep normal markdown image
  if ext == ".svg" then
    img.src = normal_rel
    return img
  end

  -- no ImageMagick: keep normal markdown image
  if not have_magick() then
    img.src = normal_rel
    return img
  end

  -- create dark; if it fails, keep normal markdown image
  if not make_dark(src_abs, dark_abs, src) then
    img.src = normal_rel
    return img
  end

  -- emit <picture> (works in GitHub; docsify-this needs asset_base to avoid partial rewriting)
  return picture_html(img.alt, normal_rel, dark_rel, img.title)
end
