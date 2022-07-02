-- Install packages from luarocks
pcall(require, "luarocks.loader")

local constants = require"constants"
local libs = constants.libs

--
require("awful.autofocus")
require("awful.hotkeys_popup.keys") -- Enable hotkeys help widget for VIM

require("error_handler") -- Handle error

libs.beautiful.init(libs.gears.filesystem.get_themes_dir() .. "default/theme.lua")

libs.awful.screen.connect_for_each_screen(function(s)

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = libs.wibox.layout.align.horizontal,
        { -- Left widgets
            layout = libs.wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        { -- Right widgets
            layout = libs.wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            libs.wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }

end)

root.keys( require"keybindings" )

libs.awful.spawn("aplay "..constants.workspace.."sounds/startup.wav")