local awful = require("awful")
local utilsClient = require("utils.client")

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tag" }),
    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tag" }),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.bydirection("up")
        end,
        { description = "focus up", group = "client" }
    ),
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.bydirection("down")
        end,
        { description = "focus down", group = "client" }
    ),
    awful.key({ modkey, }, "h",
        function()
            awful.client.focus.bydirection("left")
        end,
        { description = "focus left", group = "client" }
    ),
    awful.key({ modkey, }, "l",
        function()
            awful.client.focus.bydirection("right")
        end,
        { description = "focus right", group = "client" }
    ),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "go back", group = "client" }),
    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end
        end,
        { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift" }, "k", function() utilsClient.move_client(client.focus, "up") end,
        { description = "swap with up", group = "client" }),
    awful.key({ modkey, "Shift" }, "j", function() utilsClient.move_client(client.focus, "down") end,
        { description = "swap with down", group = "client" }),
    awful.key({ modkey, "Shift" }, "h", function() utilsClient.move_client(client.focus, "left") end,
        { description = "swap with left", group = "client" }),
    awful.key({ modkey, "Shift" }, "l", function() utilsClient.move_client(client.focus, "right") end,
        { description = "swap with right", group = "client" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, "Control" }, "l", function() utilsClient.resize_client(client.focus, "right") end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() utilsClient.resize_client(client.focus, "left") end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Control" }, "j", function() utilsClient.resize_client(client.focus, "down") end,
        { description = "increase master height factor", group = "layout" }),
    awful.key({ modkey, "Control" }, "k", function() utilsClient.resize_client(client.focus, "up") end,
        { description = "decrease master height factor", group = "layout" }),
    awful.key({ modkey, "Control", "Shift" }, "k", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control", "Shift" }, "j", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, "Control", "Shift" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, "Control", "Shift" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),
})
