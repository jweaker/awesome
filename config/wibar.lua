local awful              = require("awful")
local wibox              = require("wibox")
local batteryarc_widget  = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local volume_widget      = require('awesome-wm-widgets.volume-widget.volume')
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
-- Keyboard map indicator and switcher
mykeyboardlayout         = awful.widget.keyboardlayout()

-- Create a textclock widget

local mytextclock        = wibox.widget.textclock(
    "<span color=\"#ffffff\" font=\"Noto Sans 10\">%a %b %d, %I:%M %p</span> ");
mytextclock.halign       = "center";
local sp                 = wibox.widget.separator()
sp.orientation           = "vertical"
sp.forced_width          = 10
sp.opacity               = 0
local mysystray          = wibox.widget.systray();
mysystray.base_size      = 20;

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({}, 1, function() awful.layout.inc(1) end),
            awful.button({}, 3, function() awful.layout.inc(-1) end),
            awful.button({}, 4, function() awful.layout.inc(-1) end),
            awful.button({}, 5, function() awful.layout.inc(1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if awful.client.focus then
                    awful.client.focus:move_to_tag(t)
                end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if awful.client.focus then
                    awful.client.focus:toggle_tag(t)
                end
            end),
            awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create the wibox

    s.mywibox = awful.wibar {
        widget = {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                sp,
                s.mypromptbox,
            },
            mytextclock,
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                sp,
                mysystray,
                sp,
                mykeyboardlayout,
                sp,
                volume_widget {
                    widget_type = "arc",
                    device = "pulse"
                },
                sp,
                batteryarc_widget {
                    show_current_level = true,
                    arc_thickness = 2,
                    show_notification_mode = "off"
                },
                sp,
                logout_menu_widget(),
                sp,
                s.mylayoutbox,
            },
        }
    }
end)

-- }}}
