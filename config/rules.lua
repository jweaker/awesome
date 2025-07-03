local ruled = require("ruled")
local awful = require("awful")
-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
  -- All clients will match this rule.
  ruled.client.append_rule({
    id = "global",
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  })

  -- Floating clients.
  ruled.client.append_rule({
    id = "floating",
    rule_any = {
      instance = { "copyq", "pinentry" },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "Sxiv",
        "Tor Browser",
        "Wpa_gui",
        "veromix",
        "xtightvncviewer",
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester", -- xev.
      },
      role = {
        "AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up",    -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  })
  ruled.client.append_rule({

    rule = { class = "zen" }, -- or "zen" depending on the class name
    properties = { 
        floating = false,
        maximized = false,
        maximized_horizontal = false,
        maximized_vertical = false,
        size_hints_honor = false,
      screen=1,
      tag="1",
      switchtotag = true
    },

    callback = function(c)
        c:connect_signal("property::activated", function()
            if c.activated then c:jump_to() end
        end)
    end

  })

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule({
    id = "titlebars",
    rule_any = { type = { "dialog" } },
    properties = { titlebars_enabled = true },
  })

  ruled.client.append_rule({
    rule = { class = "Telegram" },
    properties = { screen = 1, tag = "9" },
  })

  ruled.client.append_rule({
    rule = { class = "raf-frontend" },
    properties = { screen = 1, tag = "3" },
  })

  ruled.client.append_rule({
    rule = { class = "Spotify" },
    properties = { screen = 1, tag = "8" },
  })
end)
-- }}}
