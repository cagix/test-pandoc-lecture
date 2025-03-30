-- GitHub Alerts: replace alert Divs with "real" GH alerts
function Div(el)
    -- Replace "note" Div with "note" alert
    if el.classes[1] == "note" then
        return pandoc.BlockQuote({pandoc.RawBlock("markdown", '[!NOTE]')} .. el.content)
    end
end

--- TODO TEST
function Pandoc(doc)
--    firstblock = pandoc.Para({pandoc.Str("FOO"), pandoc.HorizontalRule()})
    firstblock = pandoc.Para(pandoc.Str("FOO"))
    table.insert(doc.blocks, 1, firstblock)
    return pandoc.Pandoc(doc.blocks, doc.meta)
end
