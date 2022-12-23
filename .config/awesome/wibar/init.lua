require('wibar.widgets')
require('wibar.taglist')
require('wibar.tasklist')

local function set_wallpaper(s)
    -- Wallpaper
    if Beautiful.wallpaper then
        local wallpaper = Beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        Gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

Awful.screen.connect_for_each_screen(function(s)
    -- set_wallpaper(s)

    -- Each screen has its own tag table.
    Awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, Awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = Awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = Awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(Gears.table.join(
                           Awful.button({ }, 3, function () Awful.layout.inc(-1) end),
                           Awful.button({ }, 4, function () Awful.layout.inc( 1) end),
                           Awful.button({ }, 5, function () Awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = Awful.widget.taglist {
        screen  = s,
        filter  = Awful.widget.taglist.filter.all,
        buttons = Taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = Awful.widget.tasklist {
        screen   = s,
        filter   = Awful.widget.tasklist.filter.currenttags,
        buttons  = Tasklist_buttons
    }

    -- Create the Wibox
    s.myWibox = Awful.wibar({ position = "top", screen = s })

    -- Add widgets to the Wibox
    s.myWibox:setup {
        layout = Wibox.layout.align.horizontal,
        { -- Left widgets
            layout = Wibox.layout.fixed.horizontal,
            --mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },

        s.mytasklist, -- Middle widget

        { -- Right widgets
            layout = Wibox.layout.fixed.horizontal,
	        Cpu_widget(),
	        Ram_widget(),
            Batteryarc_widget({enable_battery_warning = false}),
            Wibox.widget.systray(),
            Mytextclock,
            s.mylayoutbox,
        },
    }
end)

os.execute('nitrogen --set-zoom-fill $(awk {print} ~/.cache/wal/wal)')
