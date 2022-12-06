--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================

local xresources = require("beautiful.xresources")
local awful = require('awful')
local gears = require('gears')
local dpi = xresources.apply_dpi

-- define module table
local theme = {}

-- ===================================================================
-- Theme Variables
-- ===================================================================
theme.name = "gruvbox"

-- Font
theme.font = "SF Pro Text 9"
theme.title_font = "SF Pro Display Medium 10"

-- Background
theme.bg_normal = "#1d2021"
theme.bg_dark = "#1d2021"
theme.bg_focus = "#282828"
theme.bg_urgent = "#98971a"
theme.bg_minimize = "#282828"

-- Foreground
theme.fg_normal = "#ebdbb2"
theme.fg_focus = "#d5c4a1"
theme.fg_urgent = "#98971a"
theme.fg_minimize = "#bdae93"

-- Window Gap Distance
theme.useless_gap = dpi(5)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(1)
theme.border_normal = "#ea6962"
theme.border_focus = theme.border_focus
theme.border_marked = theme.border_focus

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_focus
theme.taglist_bg_urgent = "#e91e6399"
theme.taglist_bg_focus = theme.bg_focus

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notification Sizing
theme.notification_max_width = dpi(350)

-- System Tray
theme.bg_systray = theme.bg_normal
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
    require_theme("components.wallpaper")

    -- Import panels
    local left_panel = require_theme("components.left-panel")
    local top_panel = require_theme("components.top-panel")

    -- Set up each screen (add tags & panels)
    awful.screen.connect_for_each_screen(function(s)
       for i = 1, 9, 1
       do
          awful.tag.add(i, {
             icon = gears.filesystem.get_configuration_dir() .. "/themes/gruvbox/tags/" .. i .. ".png",
             icon_only = true,
             layout = awful.layout.suit.tile,
             screen = s,
             selected = i == 1
          })
       end

       -- Only add the left panel on the primary screen
       if s.index == 1 then
          left_panel.create(s)
       end
       -- Add the top panel to every screen
       top_panel.create(s)
    end)
end

return theme
