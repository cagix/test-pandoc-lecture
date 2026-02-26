
title = ""

function _header(el)
    if el.level == 1 then
      return el:walk {
        Str = function(el)
            return pandoc.Str(pandoc.text.upper(el.text .. " (" .. title .. ")"))
        end
      }
    end
end

function _image (elem)
  if elem.src then
    local mt, contents = pandoc.mediabag.lookup(elem.src)
    pandoc.log.warn(pandoc.utils.stringify(elem.src) .. " (" .. (mt or "nil") .. ")")
  end
end

function _meta(m)
  if m.title then
     title = pandoc.utils.stringify(m.title)
  end
end

function Pandoc(doc)
  local fp = 'media/hello.txt'
  local mt = 'text/plain'
  local contents = 'Hello, World!'
  pandoc.mediabag.insert(fp, mt, contents)

  for fp, mt, contents in pandoc.mediabag.items() do
    pandoc.log.warn(pandoc.utils.stringify(contents))
  end

  doc = doc:walk { Meta = _meta } -- (1)
  return doc:walk {Image = _image }:walk { Header = _header }  -- (2)
end
