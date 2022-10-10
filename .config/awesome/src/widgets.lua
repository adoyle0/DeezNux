-- Widgets
Calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
Cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
Ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
Battery_widget = require("awesome-wm-widgets.battery-widget.battery")

Mytextclock = Wibox.widget.textclock()

local cw = Calendar_widget({
	placement = 'top_right',
	start_sunday = 'true',
	previous_month_button = 4,
	next_month_button = 5,
})

Mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)
