-- GitHub Alerts: replace alert Divs with "real" GH alerts
function Div(el)
    -- Replace "note" Div with "note" alert
    if el.classes[1] == "note" then
        return pandoc.BlockQuote({pandoc.RawBlock("markdown", '[!NOTE]')} .. el.content)
    end
end
