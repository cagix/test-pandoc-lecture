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

    -- 1. Title
    if doc.meta.title then
        blocks:insert(pandoc.Header(1, doc.meta.title))
    end

    hblocks:insert(pandoc.Para(pandoc.Str("FOO (via Filter)")))
    if doc.meta.tldr then
        hblocks:insert(pandoc.BlockQuote({pandoc.RawBlock("markdown", '[!IMPORTANT]')} .. doc.meta.tldr))
    end

    if doc.meta.youtube then
        local bullets = pandoc.List()
        for _, v in ipairs(doc.meta.youtube) do
            local str_link = pandoc.utils.stringify(v.link)
            bullets:insert(pandoc.Link(v.name or str_link, str_link))
        end
        hblocks:insert(pandoc.RawBlock("markdown", '<details>'))
        hblocks:insert(pandoc.RawBlock("markdown", '<summary>Videos</summary>'))
        hblocks:insert(pandoc.BulletList(bullets))
        hblocks:insert(pandoc.RawBlock("markdown", '</details>'))
    end

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    hblocks:extend(doc.blocks)

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    if doc.meta.readings then
        hblocks:insert(pandoc.Header(2, "Zum Nachlesen"))
        hblocks:insert(pandoc.BulletList(doc.meta.readings))
    end

    if doc.meta.refs then
        hblocks:insert(pandoc.Header(2, "Quellen"))
        hblocks:extend(doc.meta.refs)
    end

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    if doc.meta.license_footer then
        hblocks:extend(doc.meta.license_footer)
    end

    hblocks:insert(pandoc.HorizontalRule())
    hblocks:insert(pandoc.HorizontalRule())

    return pandoc.Pandoc(hblocks, doc.meta)
end
