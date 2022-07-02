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
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Terminal constants 
terminal = "xfce4-terminal"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
super = "Mod4"

-- Update the repository & restart awesome
local function restart_awesome()
    awful.spawn("cd .config/awesome && gh repo sync") -- update my thing 
    awesome.restart() 
end

-- launcher
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. "  man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", restart_awesome},
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

-- Keybinds
globalkeys = gears.table.join(
    awful.key(
        { super, }, "Return", function () awful.spawn(terminal) end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key( -- Restart the window manager
        { super, }, "r", restart_awesome,
        {description = "re", group = "window manager"}
    )
)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
    
-- FOCUS
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)