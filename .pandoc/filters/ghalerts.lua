-- GitHub Alerts: replace alert Divs with "real" GH alerts
function Div(el)
    -- Replace "note" Div with "note" alert
    if el.classes[1] == "note" then
        return pandoc.BlockQuote({pandoc.RawBlock("markdown", '[!NOTE]')} .. el.content)
    end
end

--- TODO TEST
function Pandoc(doc)
    local blocks = pandoc.List()

    -- 1. Title
    if doc.meta.title then
        blocks:insert(pandoc.Header(1, doc.meta.title))
    end

    -- 2. TL;DR and Videos
    if doc.meta.tldr or doc.meta.youtube or doc.meta.attachments then
        local quote = pandoc.List()

        quote:insert(pandoc.RawBlock("markdown", '[!IMPORTANT]'))

        if doc.meta.tldr then
            quote:insert(pandoc.RawBlock("markdown", '<strong>TL;DR</strong>'))
            quote:extend(doc.meta.tldr)
        end

        if doc.meta.youtube then
            local bullets = pandoc.List()
            for _, v in ipairs(doc.meta.youtube) do
                local str_link = pandoc.utils.stringify(v.link)
                bullets:insert(pandoc.Link(v.name or str_link, str_link))
            end
            quote:insert(pandoc.RawBlock("markdown", '<details>'))
            quote:insert(pandoc.RawBlock("markdown", '<summary><strong>Videos</strong></summary>'))
            quote:insert(pandoc.BulletList(bullets))
            quote:insert(pandoc.RawBlock("markdown", '</details>'))
        end

        if doc.meta.attachments then
            local bullets = pandoc.List()
            for _, v in ipairs(doc.meta.attachments) do
                local str_link = pandoc.utils.stringify(v.link)
                bullets:insert(pandoc.Link(v.name or str_link, str_link))
            end
            quote:insert(pandoc.RawBlock("markdown", '<details>'))
            quote:insert(pandoc.RawBlock("markdown", '<summary><strong>Slides</strong></summary>'))
            quote:insert(pandoc.BulletList(bullets))
            quote:insert(pandoc.RawBlock("markdown", '</details>'))
        end

        blocks:insert(pandoc.BlockQuote(quote))
    end

    -- 3. main doc
    blocks:insert(pandoc.HorizontalRule())
    blocks:extend(doc.blocks)
    blocks:insert(pandoc.HorizontalRule())

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
