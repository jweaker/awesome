local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function() mymainmenu:toggle() end),
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Key bindings

-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),
  awful.key({}, "Print", function() awful.spawn("flameshot gui") end),
  awful.key({ modkey }, "]", function() volume_widget:inc(5) end),
  awful.key({ modkey }, "[", function() volume_widget:dec(5) end),
  awful.key({ modkey }, "\\", function() volume_widget:toggle() end),
  awful.key({ modkey, }, "d", function() awful.spawn.with_shell("rofi -show drun") end,
    { description = "drun rofi", group = "launcher" }),
  awful.key({ modkey, "Control" }, "d", function() awful.spawn.with_shell("rofi -show run") end,
    { description = "run rofi", group = "launcher" }),
  awful.key({ modkey }, "e", function() awful.spawn.with_shell("rofi -show window") end,
    { description = "window rofi", group = "launcher" }),
  awful.key({ modkey, }, "w", function() mymainmenu:show() end,
    { description = "show main menu", group = "awesome" }),
  awful.key({ modkey, "Control" }, "r", awesome.restart,
    { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, "Shift" }, "q", awesome.quit,
    { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "x",
    function()
      awful.prompt.run {
        prompt       = "Run Lua code: ",
        textbox      = awful.screen.focused().mypromptbox.widget,
        exe_callback = awful.util.eval,
        history_path = awful.util.get_cache_dir() .. "/history_eval"
      }
    end,
    { description = "lua execute prompt", group = "awesome" }),
  awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end,
    { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
    { description = "run prompt", group = "launcher" }),
  awful.key({ modkey }, "p", function() menubar.show() end,
    { description = "show the menubar", group = "launcher" }),

  -- mouse
  awful.key({ modkey }, "Left", function()
      mouse.coords {
        x = mouse.coords().x - 20,
      }
    end
    ,
    { description = "move mouse left", group = "mouse" }),
  awful.key({ modkey }, "Right", function()
      mouse.coords {
        x = mouse.coords().x + 20,
      }
    end
    ,
    { description = "move mouse right", group = "mouse" }),
  awful.key({ modkey }, "Up", function()
      mouse.coords {
        y = mouse.coords().y - 20,
      }
    end
    ,
    { description = "move mouse up", group = "mouse" }),
  awful.key({ modkey }, "Down", function()
      mouse.coords {
        y = mouse.coords().y + 20,
      }
    end
    ,
    { description = "move mouse down", group = "mouse" }),

  awful.key({ modkey, "Control" }, "Down", function()
      awful.util.spawn("sh -c 'xdotool click --clearmodifiers 5'")
    end
    ,
    { description = "scroll down", group = "mouse" }),

  awful.key({ modkey, "Control" }, "Up", function()
      awful.util.spawn("sh -c 'xdotool click --clearmodifiers 4'")
    end
    ,
    { description = "scroll up", group = "mouse" }),
  awful.key({ modkey }, "Delete", function()
      awful.util.spawn("sh -c 'xdotool click --clearmodifiers 1'")
    end
    ,
    { description = "mouse leftclick", group = "mouse" }),
  awful.key({ modkey }, "End", function()
      awful.util.spawn("sh -c 'xdotool click --clearmodifiers 3'")
    end
    ,
    { description = "mouse rightclick", group = "mouse" }),
})
