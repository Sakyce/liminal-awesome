-- Install packages from luarocks
pcall(require, "luarocks.loader")

local constants = require"constants"
local libs = constants.libs

--
require("awful.autofocus")
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for VIM

require("error_handler") -- Handle error

libs.beautiful.init(libs.gears.filesystem.get_themes_dir() .. "default/theme.lua")

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        libs.gears.wallpaper.maximized(wallpaper, s, true)
    end
end
screen.connect_signal("property::geometry", set_wallpaper)

libs.awful.screen.connect_for_each_screen(function(scr)
    set_wallpaper(scr)

    -- create objects
    

    scr.mywibox:setup{}
end)

screen.connect_signal("request::wallpaper", function(s)
    libs.awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = beautiful.wallpaper,
                upscale   = true,
                downscale = true,
                widget    = libs.wibox.widget.imagebox,
            },
            valign = "center",
            halign = "center",
            tiled  = false,
            widget = libs.wibox.container.tile,
        }
    }
end)

--root.keys( require"keybindings" )

libs.awful.spawn("aplay "..constants.workspace.."sounds/startup.wav")