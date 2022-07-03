-- Install packages from luarocks
pcall(require, "luarocks.loader")

local constants = require"constants"
local libs = constants.libs

--
require("awful.autofocus")
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for VIM

require("error_handler") -- Handle error

libs.beautiful.init(libs.gears.filesystem.get_themes_dir() .. "default/theme.lua")

local current_theme = require("mythemes").Chicago

local suit = libs.awful.layout.suit

libs.awful.layout.layouts = {
    suit.floating, suit.tile, suit.tile.left, suit.tile.bottom, suit.tile.top, suit.fair, suit.fair.horizontal, 
    suit.spiral, suit.spiral.dwindle, suit.max, suit.max.fullscreen, suit.magnifier, suit.corner.nw,
}

local function set_wallpaper(s)
    if libs.beautiful.wallpaper then
        
        local wallpaper = libs.beautiful.wallpaper
        wallpaper = type(wallpaper) == "function" and wallpaper(s) or wallpaper  
        
        libs.gears.wallpaper.maximized(constants.workspace..current_theme.wallpaper, s, true)

    end
end
screen.connect_signal("property::geometry", set_wallpaper)

libs.awful.screen.connect_for_each_screen(function(scr)
    set_wallpaper(scr)
    
    libs.awful.tag( {"1"}, scr, libs.awful.layout.layouts[1] )

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

-- Window managing
client.connect_signal("manage", function(window)
    libs.awful.placement.no_offscreen(window)
end)
-- client.connect_signal("request::titlebars", function(window)
--     libs.awful.titlebar(window):setup{  }
-- end)


--root.keys( require"keybindings" )

libs.awful.spawn( constants.terminal, {floating = true} )
libs.awful.spawn( "firefox", {floating = true} )
libs.awful.spawn( "aplay "..constants.workspace..current_theme.startup_sound )