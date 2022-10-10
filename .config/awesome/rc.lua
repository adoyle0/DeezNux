require('src.error_handler')
require("awful.autofocus")
require("awful.hotkeys_popup.keys")

--

Gears         = require("gears")
Awful         = require("awful")
Wibox         = require("wibox")
Beautiful     = require("beautiful")
Naughty       = require("naughty")
Menubar       = require("menubar")
Hotkeys_popup = require("awful.hotkeys_popup")

Terminal      = "kitty"
Editor        = "nvim"
Editor_cmd    = Terminal .. " -e " .. Editor
Browser       = "firefox-developer-edition"
Browser2      = "brave-nightly"
Music         = "spotify"
Modkey        = "Mod4"

Beautiful.init(".config/awesome/theme.lua")

Awful.layout.layouts = {
    Awful.layout.suit.tile.right,
    Awful.layout.suit.tile.top,
    Awful.layout.suit.tile.left,
    Awful.layout.suit.tile.bottom,
}

--

Menubar.utils.terminal = Terminal -- Set the terminal for applications that require it
require('src.screen_setup')

require('src.binds')

require('src.rules')

require('src.signals')

Gears.timer.start_new(10, function() collectgarbage("step", 20000) return true end)
