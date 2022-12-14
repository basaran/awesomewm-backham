
--+ allows automatically focusing back to the previous client
--> on window close (unmanage) or minimize.

-------------------------------------------------------------------> imports ;

local awful = require("awful")

-------------------------------------------------------------------> methods ;

function backham()
    local s = awful.screen.focused()
    local c = awful.client.focus.history.get(s, 0)
    if c then
        client.focus = c
        c:raise()
    end
end

--------------------------------------------------------------------> signal ;

client.connect_signal("property::minimized", backham)
--+ attach to minimized state

client.connect_signal("unmanage", backham)
--+ attach to closed state

--------------------------------------------------------
-- Fixes the problem of losing focus after changing the workspace

-- Grab focus on first client on screen
function grab_focus()
    local all_clients = client.get()
    for i, c in pairs(all_clients) do
        if c:isvisible() and c.class ~= "Conky" then
            client.focus = c
        end
    end
end

-- Bind all key numbers to tags.
if tags[screen][i] then
    awful.tag.viewonly(tags[screen][i])
    grab_focus()
end

