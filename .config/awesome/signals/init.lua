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
