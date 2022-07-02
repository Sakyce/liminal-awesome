-- Load luarocks for any reason
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout
local wibox = require("wibox")

-- Theme handling
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Error handling
require("error_handler")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Terminal constants 
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
super = "Mod4"

-- launcher
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. "  man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
 }
mymainmenu = awful.menu({ 
    items = { 
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
menubar.utils = terminal
mykeyboardlayout = awful.widget.keyboardlayout()

awful.rules.rules = require("liminal_rules") -- Set window rules