local constants = {}

-- Load standard libs
local libs = {}
libs.gears = require("gears") -- Standard awesome library
libs.awful = require("awful")
libs.wibox = require("wibox") -- Widget and layout library
libs.beautiful = require("beautiful") -- Theme handling library
libs.naughty = require("naughty") -- Notification library
libs.menubar = require("menubar")
libs.hotkeys_popup = require("awful.hotkeys_popup")
constants.libs = libs

constants.terminal = "xfce4-terminal"
constants.editor = os.getenv("EDITOR") or "nano"
constants.editor_cmd = constants.terminal .. " -e " .. constants.editor
constants.super = "Mod4"
constants.workspace = ".config/awesome/"

return constants