require('binds.global')
require('binds.client')

-- Mouse
root.buttons(Gears.table.join(
    Awful.button({ }, 4, Awful.tag.viewnext),
    Awful.button({ }, 5, Awful.tag.viewprev)
))
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
