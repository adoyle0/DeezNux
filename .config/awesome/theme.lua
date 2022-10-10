local theme_assets  = require("beautiful.theme_assets")
local xresources    = require("beautiful.xresources")
local dpi           = xresources.apply_dpi
local xrdb          = xresources.get_current_theme()

local theme = {}

theme.font          = "monospace 11"
theme.wallpaper     = '.cache/wal/bg'

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(1)

-- Colors
theme.bg_normal     = xrdb.background
theme.bg_focus      = xrdb.color4
theme.bg_urgent     = xrdb.color1
theme.bg_minimize   = xrdb.color4
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = xrdb.foreground
theme.fg_urgent     = xrdb.foreground
theme.fg_minimize   = xrdb.foreground

theme.border_normal = xrdb.color5
theme.border_focus  = xrdb.color4
theme.border_marked = xrdb.color10

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
