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
