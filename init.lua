
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

local function focus_after_tag_change()
    local current_tag = awful.tag.selected(1)
    if current_tag == nil then 
        return nil
    end

    local table_of_clients = current_tag:clients()
    local last_client = table_of_clients[#table_of_clients]
    local first_client = table_of_clients[0] or table_of_clients[1]

    local c = last_client ~= nil and last_client or first_client

    if c == nil then
        return nil
    end
    		
    client.focus = c
    c:raise()
end

tag.connect_signal("property::selected", focus_after_tag_change)