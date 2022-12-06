--      ██╗     ███████╗███████╗████████╗    ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ██║     ██╔════╝██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--      ██║     █████╗  █████╗     ██║       ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--      ██║     ██╔══╝  ██╔══╝     ██║       ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--      ███████╗███████╗██║        ██║       ██║     ██║  ██║██║ ╚████║███████╗███████╗
--      ╚══════╝╚══════╝╚═╝        ╚═╝       ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi
local awful = require("awful")
local gears = require("gears")

local tag_list = require("widgets.tag-list")
local separator = require("widgets.horizontal-separator")
local folder = require("widgets.folder")

local home_dir = os.getenv("HOME")

-- define module table
local left_panel = {}


-- ===================================================================
-- Bar Creation
-- ===================================================================


left_panel.create = function(s)
   local maximized_panel_shape = function(cr, width, height)
      gears.shape.rectangle(cr, width, height)
   end

   panel_width = 40
   panel = awful.wibar({
      screen = s,
      position = "left",
      height = s.geometry.height * 7/10,
      width = panel_width,
      ontop = true,
      shape = maximized_panel_shape
   })

   panel:setup {
      expand = "none",
      layout = wibox.layout.align.vertical,
      nil,
      {
         layout = wibox.layout.fixed.vertical,
         -- add taglist widget
         tag_list.create(s),
         -- add folders widgets
         {
            separator,
            folder.create(home_dir),
            folder.create(home_dir .. "/Documents"),
            folder.create(home_dir .. "/Downloads"),
            layout = wibox.layout.fixed.vertical,
         }
      },
      nil
   }

   -- panel background that becomes visible when client is maximized
   panel_bg = wibox({
      screen = s,
      position = "left",
      height = s.geometry.height,
      width = panel_width,
      visible = true
   })

  
   -- ===================================================================
   -- functionality
   -- ===================================================================


   -- hide panel when client is fullscreen
   local function change_panel_visibility(client)
      if client.screen == s then
         panel.ontop = not client.fullscreen
      end
   end

   -- connect panel visibility function to relevant signals
   client.connect_signal("property::fullscreen", change_panel_visibility)
   client.connect_signal("focus", change_panel_visibility)
end

return left_panel
