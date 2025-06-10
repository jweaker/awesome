local awful = require("awful")
local client = client

local function focus_browser()
    local clients = client.get()
    for _, c in ipairs(clients) do
        -- Match Zen-Browser (update class if needed)
        if c.class and (c.class:lower():match("zen") or c.class:lower():match("browser")) then
            local c_tag = c.first_tag
            if c_tag and c_tag.index == 1 then
                c_tag:view_only()
                client.focus = c
                c:raise()
                return
            end
        end
    end
    
    -- Fallback to workspace 1 if browser not found
    local screen = awful.screen.focused()
    if screen.tags[1] then
        screen.tags[1]:view_only()
    end
end

return focus_browser
