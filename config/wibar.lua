local awful              = require("awful")
local wibox              = require("wibox")
local gears              = require("gears")

-- Keyboard map indicator and switcher
mykeyboardlayout         = awful.widget.keyboardlayout()

-- Create a textclock widget

local mytextclock        = wibox.widget.textclock("%a %b %d, %I:%M %p");
mytextclock.halign       = "center";
local myseparator        = wibox.widget.separator()
myseparator.orientation  = "vertical"
myseparator.forced_width = 20
myseparator.opacity      = 0
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

    -- Create a tasklist widget
    -- s.mytasklist = awful.widget.tasklist {
    --     screen          = s,
    --     filter          = awful.widget.tasklist.filter.currenttags,
    --     style           = {
    --         border_width = 1,
    --         border_color = '#777777',
    --         shape        = gears.shape.rounded_bar,
    --     },
    --     layout          = {
    --         spacing        = 10,
    --         spacing_widget = {
    --             {
    --                 forced_width = 5,
    --                 shape        = gears.shape.circle,
    --                 widget       = wibox.widget.separator
    --             },
    --             valign = 'center',
    --             halign = 'center',
    --             widget = wibox.container.place,
    --         },
    --         layout         = wibox.layout.flex.horizontal
    --     },
    --     -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    --     -- not a widget instance.
    --     widget_template = {
    --         {
    --             {
    --                 {
    --                     {
    --                         id     = 'icon_role',
    --                         widget = wibox.widget.imagebox,
    --                     },
    --                     margins = 2,
    --                     widget  = wibox.container.margin,
    --                 },
    --                 {
    --                     id     = 'text_role',
    --                     widget = wibox.widget.textbox,
    --                 },
    --                 layout = wibox.layout.fixed.horizontal,
    --             },
    --             left   = 10,
    --             right  = 10,
    --             widget = wibox.container.margin
    --         },
    --         id     = 'background_role',
    --         widget = wibox.container.background,
    --     },
    -- }

    -- Create the wibox


    s.mywibox = awful.wibar {
        widget = {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
                s.mypromptbox,
            },
            { mytextclock, layout = wibox.container.place },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                myseparator,
                mysystray,
                myseparator,
                mykeyboardlayout,
                myseparator,
                s.mylayoutbox,
            },
        }
    }
end)

-- }}}
