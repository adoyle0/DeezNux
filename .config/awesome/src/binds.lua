-- {{{ Mouse bindings
root.buttons(Gears.table.join(
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
