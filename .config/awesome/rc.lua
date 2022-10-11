require('core')

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

Menubar.utils.terminal = Terminal -- Set the terminal for applications that require it

require('wibar')
require('binds')
require('rules')
require('signals')

Gears.timer.start_new(10, function() collectgarbage("step", 20000) return true end)
