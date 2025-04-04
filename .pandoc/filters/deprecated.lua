
-- Issue a warning if users use elements that are no longer supported (spans, divs, classes, ...)

local function warning(w)
    io.stderr:write("\n\n" .. "[WARNING: ]" .. w .. "\n\n")
end


function Span(el)
    if el.classes[1] == "cbox" then
        warning("Span `cbox`: `[...]{.cbox}` is no longer supported")
    end
end


function Div(el)
    if el.classes[1] == "cbox" then
        warning("Div `cbox`: `::: cbox ... :::` is no longer supported")
    end

    if el.classes[1] == "showme" then
        warning("Div `showme`: `::: showme ... :::` is no longer supported => please use Div `details` instead (`::: details ... :::`)")
    end
end
