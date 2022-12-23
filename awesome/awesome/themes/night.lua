local xresources = require("beautiful.xresources")
local awful = require('awful')
local gears = require('gears')
local dpi = xresources.apply_dpi

local theme = {}
theme.name = "night"

theme.background = "#061115"
theme.foreground = "#D9D7D6"
theme.black      = "#1C252C"
theme.red        = "#DF5B61"
theme.green      = "#78B892"
theme.yellow     = "#DE8F78"
theme.blue       = "#6791C9"
theme.magenta    = "#BC83E3"
theme.cyan       = "#67AFC1"
theme.white      = "#D9D7D6"
theme.blacks     = "#484E5B"
theme.reds       = "#F16269"
theme.greens     = "#8CD7AA"
theme.yellows    = "#E9967E"
theme.blues      = "#79AAEB"
theme.magentas   = "#C488EC"
theme.cyans      = "#7ACFE4"
theme.whites     = "#E5E5E5"
theme.darker_bg  = "#0A1419"
theme.lighter_bg = "#162026"
theme.transparent = "#00000000"

-- Font
theme.font = "SF Pro Text 9"
theme.title_font = "SF Pro Display Medium 10"
theme.title_font_bold = "SF Pro Display Bold 10"

theme.bg_normal     = "#061115"
theme.bg_subtle     = "#0a171c"
theme.bg_focus      = "#1C252C"
theme.bg_cal        = "#78B892"
theme.bg_urgent     = "#DF5B61"
theme.bg_minimize   = "#484e5b"
theme.bg_systray    = theme.bg_normal


theme.fg_normal     = "#D9D7D6"
theme.fg_focus      = "#D9D7D6"
theme.fg_urgent     = "#D9D7D6"
theme.fg_minimize   = "#D9D7D6"

-- Window Gap Distance
theme.useless_gap = dpi(5)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true
theme.border_width        = dpi(1)
theme.border_color_normal = "#000000"
theme.border_color_active = "#535d6c"
theme.border_color_marked = "#91231c"

theme.titlebar_bg_focus  = theme.bg_subtle
theme.titlebar_bg_normal = theme.bg_normal

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_focus
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font


theme.taglist_fg_focus      = "#78B892"
theme.taglist_bg_focus      = "#061115"
theme.taglist_fg_occupied   = "#d9d7d6"

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.systray_icon_spacing = dpi(5)

-- Titlebars
theme.titlebars_enabled = false


-- ===================================================================
-- Icons
-- ===================================================================


-- Define layout icons
theme.layout_tile = "~/.config/awesome/icons/layouts/tiled.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_max = "~/.config/awesome/icons/layouts/maximized.png"

theme.icon_theme = "Tela-dark"

-- return theme

theme.initialize = function()
    -- Import components
    require("components.wallpaper")

    -- Import panels
    local top_panel = require("components.top-panel")

    -- Set up each screen (add tags & panels)
    awful.screen.connect_for_each_screen(function(s)
       for i = 1, 9, 1
       do
          awful.tag.add(i, {
             icon = gears.filesystem.get_configuration_dir() .. "/icons/tags/" .. i .. ".png",
             icon_only = true,
             layout = awful.layout.suit.tile,
             screen = s,
             selected = i == 1
          })
       end

       -- Add the top panel to every screen
       top_panel.create(s)
    end)
end

return theme
