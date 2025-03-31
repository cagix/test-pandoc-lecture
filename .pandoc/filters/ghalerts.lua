-- GitHub Alerts: replace alert Divs with "real" GH alerts
function Div(el)
    -- Replace "note" Div with "note" alert
    if el.classes[1] == "note" then
        return pandoc.BlockQuote({pandoc.RawBlock("markdown", '[!NOTE]')} .. el.content)
    end
end

--- TODO TEST
function Pandoc(doc)
    local hblocks = pandoc.List()

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    hblocks:insert(pandoc.Para(pandoc.Str("FOO (via Filter)")))
    if doc.meta.tldr then
        hblocks:extend(doc.meta.tldr)
    end

    if doc.meta.youtube then
        local bullets = pandoc.List()
        for _, v in ipairs(doc.meta.youtube) do
            local str_link = pandoc.utils.stringify(v.link)
            bullets:insert(pandoc.Link(v.name or str_link, str_link))
        end
        hblocks:insert(pandoc.BulletList(bullets))
    end

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    hblocks:extend(doc.blocks)

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    if doc.meta.license_footer then
        hblocks:extend(doc.meta.license_footer)
    end

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    return pandoc.Pandoc(hblocks, doc.meta)
end
