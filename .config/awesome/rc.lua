-- Include
require('src.error_handler')
require('src.core_globals')
require('src.user_globals')
require('src.layouts')

-- seemingly important stuff
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

Menubar.utils.terminal = Terminal -- Set the terminal for applications that require it

require('src.widgets')

-- Create a Wibox for each screen and add it
local taglist_buttons = Gears.table.join(
                    Awful.button({ }, 1, function(t) t:view_only() end),
                    Awful.button({ Modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    Awful.button({ }, 3, Awful.tag.viewtoggle),
                    Awful.button({ Modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    Awful.button({ }, 4, function(t) Awful.tag.viewnext(t.screen) end),
                    Awful.button({ }, 5, function(t) Awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = Gears.table.join(
                     Awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     Awful.button({ }, 3, function()
                                              Awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     Awful.button({ }, 4, function ()
                                              Awful.client.focus.byidx(1)
                                          end),
                     Awful.button({ }, 5, function ()
                                              Awful.client.focus.byidx(-1)
                                          end))

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
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    Awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, Awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = Awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = Awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(Gears.table.join(
                           Awful.button({ }, 1, function () Awful.layout.inc( 1) end),
                           Awful.button({ }, 3, function () Awful.layout.inc(-1) end),
                           Awful.button({ }, 4, function () Awful.layout.inc( 1) end),
                           Awful.button({ }, 5, function () Awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = Awful.widget.taglist {
        screen  = s,
        filter  = Awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = Awful.widget.tasklist {
        screen  = s,
        filter  = Awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
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
            Battery_widget(),
            Mykeyboardlayout,
            Wibox.widget.systray(),
            Mytextclock,
            s.mylayoutbox,
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(Gears.table.join(
    Awful.button({ }, 3, function () mymainmenu:toggle() end),
    Awful.button({ }, 4, Awful.tag.viewnext),
    Awful.button({ }, 5, Awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = Gears.table.join(
    Awful.key({ Modkey,           }, "F1",      Hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    Awful.key({ Modkey,           }, "j",
        function ()
            Awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    Awful.key({ Modkey,           }, "k",
        function ()
            Awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    Awful.key({ Modkey, 	  }, "l", function () Awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    Awful.key({ Modkey, 	  }, "h", function () Awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    Awful.key({ Modkey,           }, "Tab",
        function ()
            Awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    Awful.key({ Modkey,           }, "w", function () Awful.spawn(Browser) end,
              {description = "open firefox", group = "launcher"}),
    Awful.key({ Modkey, "Shift"   }, "w", function () Awful.spawn(Browser2) end,
              {description = "open brave",   group = "launcher"}),
    Awful.key({ Modkey,           }, "e", function () Awful.spawn(Editor_cmd) end,
              {description = "open editor",    group = "launcher"}),
    Awful.key({ Modkey, "Shift"   }, "e", function () Awful.spawn("thunderbird") end,
              {description = "open thunderbird", group = "launcher"}),
    Awful.key({ Modkey,           }, "m", function () Awful.spawn(Music) end,
              {description = "open spotify", group = "launcher"}),
    Awful.key({ Modkey,           }, "d", function () Awful.spawn("discord") end,
              {description = "open discord", group = "launcher"}),
    Awful.key({ Modkey,           }, "c", function () Awful.spawn("caprine") end,
              {description = "open caprine", group = "launcher"}),
    Awful.key({ Modkey, "Shift"   }, "c", function () Awful.spawn("telegram-desktop") end,
              {description = "open telegram-desktop", group = "launcher"}),
    Awful.key({ Modkey,           }, "g", function () Awful.spawn("godot") end,
              {description = "open godot",   group = "launcher"}),
    Awful.key({ Modkey, "Shift"   }, "g", function () Awful.spawn("steam-native") end,
              {description = "open steam",   group = "launcher"}),
    Awful.key({ Modkey,           }, "Return", function () Awful.spawn(Terminal) end,
              {description = "open a terminal", group = "launcher"}),
    Awful.key({ Modkey, 	  }, "BackSpace", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    Awful.key({ Modkey, "Shift"   }, "Escape", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    Awful.key({ Modkey,           }, "v", function () Awful.spawn("virt-manager") end,
              {description = "open virt-manager",   group = "launcher"}),

    Awful.key({ Modkey, "Shift"   }, "k",     function () Awful.tag.incmwfact( 0.05)          end,
              {description = "resize vsplit up", group = "layout"}),
    Awful.key({ Modkey, "Shift"   }, "j",     function () Awful.tag.incmwfact(-0.05)          end,
              {description = "resize vsplit down", group = "layout"}),

    Awful.key({ Modkey,           }, "space", function () Awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    Awful.key({ Modkey, "Shift"   }, "space", function () Awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    Awful.key({ Modkey, "Control" }, "n",
              function ()
                  local c = Awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    Awful.key({ Modkey },            "r",     function () Awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    Awful.key({ Modkey }, "x",
              function ()
                  Awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = Awful.screen.focused().mypromptbox.widget,
                    exe_callback = Awful.util.eval,
                    history_path = Awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    Awful.key({ Modkey }, "p", function() Menubar.show() end,
              {description = "show the Menubar", group = "launcher"})
)

clientkeys = Gears.table.join(
    Awful.key({}, "Print", function() os.execute("maimpick") end),
    Awful.key({}, "XF86AudioPlay", function() os.execute("playerctl play-pause") end),
    Awful.key({}, "XF86AudioStop", function() os.execute("playerctl stop") end),
    Awful.key({}, "XF86AudioNext", function() os.execute("playerctl next") end),
    Awful.key({}, "XF86AudioPrev", function() os.execute("playerctl previous") end),
    Awful.key({}, "XF86AudioRaiseVolume", function() os.execute("pamixer -i 3") end),
    Awful.key({}, "XF86AudioLowerVolume", function() os.execute("pamixer -d 3") end),
    Awful.key({}, "XF86AudioMute", function() os.execute("pamixer -t") end),
    Awful.key({}, "XF86AudioMicMute", function() os.execute("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end),
    Awful.key({ Modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    Awful.key({ Modkey, 	  }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    Awful.key({ Modkey, "Control" }, "space",  Awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    Awful.key({ Modkey, "Control" }, "Return", function (c) c:swap(Awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    Awful.key({ Modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    Awful.key({ Modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    Awful.key({ Modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    Awful.key({ Modkey, "Shift" }, "n",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    Awful.key({ Modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    Awful.key({ Modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = Gears.table.join(globalkeys,
        -- View tag only.
        Awful.key({ Modkey }, "#" .. i + 9,
                  function ()
                        local screen = Awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        Awful.key({ Modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = Awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         Awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        Awful.key({ Modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        Awful.key({ Modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = Gears.table.join(
    Awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    Awful.button({ Modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        Awful.mouse.client.move(c)
    end),
    Awful.button({ Modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        Awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
Awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = Beautiful.border_width,
                     border_color = Beautiful.border_normal,
                     focus = Awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = Awful.screen.preferred,
                     placement = Awful.placement.no_overlap+Awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        Awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = Gears.table.join(
        Awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            Awful.mouse.client.move(c)
        end),
        Awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            Awful.mouse.client.resize(c)
        end)
    )

    Awful.titlebar(c) : setup {
        { -- Left
            Awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = Wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = Awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = Wibox.layout.flex.horizontal
        },
        { -- Right
            Awful.titlebar.widget.floatingbutton (c),
            Awful.titlebar.widget.maximizedbutton(c),
            Awful.titlebar.widget.stickybutton   (c),
            Awful.titlebar.widget.ontopbutton    (c),
            Awful.titlebar.widget.closebutton    (c),
            layout = Wibox.layout.fixed.horizontal()
        },
        layout = Wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = Beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = Beautiful.border_normal end)
-- }}}
Gears.timer.start_new(10, function() collectgarbage("step", 20000) return true end)
