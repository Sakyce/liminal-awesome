-- Don't require this module in constants or stack overflow

local const = require"constants"
local libs = constants.libs

local globalkeys = libs.gears.table.join(

    -- Standard program
    libs.awful.key({const.super}, "Return", function () libs.awful.spawn(const.terminal) end,
        {description = "open a terminal", group = "launcher"}),

    libs.awful.key({const.super}, "r", function() 
        libs.awful.util.spawn("cd ~/.config/awesome && gh repo sync") 
        awesome.restart()
    end, {description = "reload awesome", group = "awesome"}),

    libs.awful.key({const.super}, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    -- Prompt
    libs.awful.key({const.super}, "r", function()
        libs.awful.screen.focused().mypromptbox:run() 
    end, {description = "run prompt", group = "launcher"}),

    libs.awful.key({const.super}, "x",function()
        libs.awful.prompt.run {
            prompt       = "Run Lua code: ",
            textbox      = libs.awful.screen.focused().mypromptbox.widget,
            exe_callback = libs.awful.util.eval,
            history_path = libs.awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {description = "lua execute prompt", group = "awesome"})
)

return globalkeys