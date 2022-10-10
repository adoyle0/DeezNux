Gears = require'gears'
Awful = require'awful'
Modkey='mod4'

Taglist_buttons = Gears.table.join(
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

Tasklist_buttons = Gears.table.join(
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
