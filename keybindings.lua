-- Don't require this module in constants or stack overflow

local const = require"constants"
local libs = const.libs

local current_theme = require"mythemes"

libs.awful.keyboard.append_global_keybindings{
    -- Standard program
    libs.awful.key({const.super}, "Return", function () libs.awful.spawn(const.terminal) end,
        {description = "open a terminal", group = "launcher"}),

    libs.awful.key({const.super}, "r", function() 
        current_theme.play('logout')
        -- Update the repo and log out
        libs.awful.spawn.easy_async("sh "..const.workspace.."update_awesome.sh", function()
            awesome.restart()
        end)
    end, {description = "reload awesome", group = "awesome"}),

    libs.awful.key({const.super}, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"})
}