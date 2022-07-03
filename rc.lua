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
    if libs.beautiful.wallpaper then
        
        local wallpaper = libs.beautiful.wallpaper
        local wallpaper = type(wallpaper) == "function" and wallpaper(s) or wallpaper  
        
        libs.gears.wallpaper.maximized(constants.workspace.."art/backgrounds_01.png", s, true)

    end
end
screen.connect_signal("property::geometry", set_wallpaper)

libs.awful.screen.connect_for_each_screen(function(scr)
    libs.beautiful.set_wallpaper()
    set_wallpaper(scr)

    -- create objects
    

    --scr.mywibox:setup{}
end)

screen.connect_signal("request::wallpaper", function(s)
    libs.awful.wallpaper {
        screen = s,
        widget = {
            {
                image     = libs.beautiful.wallpaper,
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