-- Install packages from luarocks
pcall(require, "luarocks.loader")

local constants = require"constants"
local libs = constants.libs

--
require("awful.autofocus")
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for VIM

require("error_handler") -- Handle error

libs.beautiful.init(libs.gears.filesystem.get_themes_dir().."default/theme.lua")

local mytheme = require("mythemes")

-- Screen layouts
local suit = libs.awful.layout.suit
libs.awful.layout.layouts = {
    suit.floating, suit.tile, suit.tile.left, suit.tile.bottom, suit.tile.top, suit.fair, suit.fair.horizontal, 
    suit.spiral, suit.spiral.dwindle, suit.max, suit.max.fullscreen, suit.magnifier, suit.corner.nw,
}
local function set_wallpaper(s)
    if libs.beautiful.wallpaper then
        
        local wallpaper = libs.beautiful.wallpaper
        wallpaper = type(wallpaper) == "function" and wallpaper(s) or wallpaper  
        
        libs.gears.wallpaper.maximized(constants.workspace..mytheme.current_theme.wallpaper, s, true)

    end
end
screen.connect_signal("property::geometry", set_wallpaper)
libs.awful.screen.connect_for_each_screen(function(scr)
    set_wallpaper(scr)
    libs.awful.tag( {"1"}, scr, libs.awful.layout.layouts[1] )
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
libs.awful.rules.rules = require"liminal_rules"
client.connect_signal("manage", function(window)
    mytheme.play( "window_open" )
    libs.awful.placement.no_offscreen(window)
end)
client.connect_signal("unmanage", function(window)
    mytheme.play( "window_close" )
end)
client.connect_signal("request::titlebars", function(window)
    local buttons = libs.gears.table.join(
        libs.awful.button({ }, 1, function()
            window:emit_signal("request::activate", "titlebar", {raise = true})
            libs.awful.mouse.client.move(window)
        end),
        libs.awful.button({ }, 3, function()
            window:emit_signal("request::activate", "titlebar", {raise = true})
            libs.awful.mouse.client.resize(window)
        end)
    )
    
    libs.awful.titlebar(window, {height=60,bg_normal='#000000'}):setup{
    -- Left
    {
        libs.awful.titlebar.widget.closebutton(window),
        libs.awful.titlebar.widget.iconwidget(window),
        {align  = "left", widget = libs.awful.titlebar.widget.titlewidget(window)},
        buttons = buttons,
        layout  = libs.wibox.layout.fixed.horizontal
    },
    -- Middle
    {
        buttons = buttons,
        layout  = libs.wibox.layout.flex.horizontal
    },
    -- Right
    {   
        buttons = buttons,
        layout = libs.wibox.layout.fixed.horizontal()
    },
    layout = libs.wibox.layout.align.horizontal
    }
end)

libs.beautiful.titlebar_bgimage = constants.workspace.."art/titlebar.png"

-- Keybindings
require"keybindings"

mytheme.play( "startup_sound" )