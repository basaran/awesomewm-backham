
--+ allows automatically focusing back to the previous client
--> on window close (unmanage) or minimize.

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