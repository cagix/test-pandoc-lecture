
local by = 0

local function shift_header (el)
    if el.level + by > 6 then pandoc.log.warn("level to deep: " .. el.level) end

    el.level = math.min(el.level + by, 6)
    return el
end

local function add_title (doc)
    blocks = doc.blocks

    local title = doc.meta.title or "NO TITLE"
    if doc.meta.title then
        table.insert(blocks, 1, pandoc.Header(by, pandoc.Str(pandoc.utils.stringify(title))))
    end

    return pandoc.Pandoc(blocks, doc.meta)
end

local function walk_bullets (bl)
    blocks = bl.blocks

    local function walk_list(list, depth)
        for _, item in ipairs(list) do
        local lnk = first_link_in_blocks(item)
        if lnk and lnk.target and lnk.target:match("%.md") and not is_abs(lnk.target) then
            local clean = (lnk.target:match("^[^#?]+") or lnk.target)
            table.insert(items, {
            title = utils.stringify(lnk.content),
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

    for _, b in ipairs(blocks) do
        if b.t == "BulletList" then walk_list(b.content, 0) end
    end

end


function Pandoc (doc)
    doc = doc:walk { Header = shift_header }: walk { BulletList = walk_bullets }
    return add_title(doc)
end
