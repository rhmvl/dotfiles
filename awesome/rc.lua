--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝


-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")


-- ===================================================================
-- User Configuration
-- ===================================================================

-- Load theme.txt file
local file = io.open(gears.filesystem.get_configuration_dir() .. "/theme.txt", "r")
local theme = file:read("*all")
file:close()
local theme_dir = "themes." .. theme .. ".theme"
local theme_config_dir = gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/config/"

-- define default apps (global variable so other components can access it)
apps = {
   browser = "firefox",
   network_manager = "", -- recommended: nm-connection-editor
   power_manager = "", -- recommended: xfce4-power-manager
   terminal = "alacritty",
   launcher = "rofi -normal-window -modi drun -show drun -theme " .. theme_config_dir .. "rofi.rasi",
   lock = "i3lock",
   screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
   filebrowser = "pcmanfm"
}

-- define wireless and ethernet interface names for the network widget
-- use `ip link` command to determine these
network_interfaces = {
   wlan = 'wlan0',
   lan = 'enp1s0'
}

-- List of apps to run on start-up
local run_on_start_up = {
   "picom --experimental-backends --config " .. theme_config_dir .. "picom.conf",
   "redshift",
   "unclutter"
}


-- ===================================================================
-- Initialization
-- ===================================================================

function require_theme (name)
   return require("themes." .. theme .. "." .. name)
end

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "/themes/" .. theme .. "/theme.lua")


-- Run all the apps listed in run_on_start_up
for _, app in ipairs(run_on_start_up) do
   local findme = app
   local firstspace = app:find(" ")
   if firstspace then
      findme = app:sub(0, firstspace - 1)
   end
   -- pipe commands to bash to allow command to be shell agnostic
   awful.spawn.with_shell(string.format("echo 'pgrep -u $USER -x %s > /dev/null || (%s)' | bash -", findme, app), false)
end

-- Initialize theme
local selected_theme = require(theme_dir)
selected_theme.initialize()

-- Import notification appearance
require("components.notifications")
require("components.exit-screen")
require("components.volume-adjust")

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- Define layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max,
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
   -- Set the window as a slave (put it at the end of others instead of setting it as master)
   if not awesome.startup then
      awful.client.setslave(c)
   end

   if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end
end)


-- ===================================================================
-- Client Focusing
-- ===================================================================


-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
client.connect_signal("mouse::enter", function(c)
   c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

-- ===================================================================
-- Screen Change Functions (ie multi monitor)
-- ===================================================================


-- Reload config when screen geometry changes
screen.connect_signal("property::geometry", awesome.restart)


-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
