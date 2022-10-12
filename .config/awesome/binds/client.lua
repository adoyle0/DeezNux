-- Keys that affect the current window
clientkeys = Gears.table.join(
    Awful.key({ Modkey,           }, "f",         function (c) c.fullscreen = not c.fullscreen c:raise()         end,
              {description = "toggle fullscreen",       group = "client"}),
    Awful.key({ Modkey,           }, "q",         function (c) c:kill()                                          end,
              {description = "close",                   group = "client"}),
    Awful.key({ Modkey,           }, "o",         function (c) c:move_to_screen()                                end,
              {description = "move to screen",          group = "client"}),
    Awful.key({ Modkey,           }, "t",         function (c) c.ontop = not c.ontop                             end,
              {description = "toggle keep on top",      group = "client"}),
    Awful.key({ Modkey, "Shift"   }, "n",         function (c) c.maximized = not c.maximized c:raise()           end,
              {description = "(un)maximize",            group = "client"}),
    Awful.key({ Modkey, "Control" }, "space",     Awful.client.floating.toggle                                      ,
              {description = "toggle floating",         group = "client"}),
    Awful.key({ Modkey, "Control" }, "Return",    function (c) c:swap(Awful.client.getmaster())                  end,
              {description = "move to master",          group = "client"}),
    Awful.key({ Modkey,           }, "j",         function () Awful.client.focus.byidx( 1)                       end,
              {description = "focus next by index",     group = "client"}),
    Awful.key({ Modkey,           }, "k",         function () Awful.client.focus.byidx(-1)                       end,
              {description = "focus previous by index", group = "client"})
)
