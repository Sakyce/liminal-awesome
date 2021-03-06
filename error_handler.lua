local constants = require"constants"
local libs = constants.libs

local current_theme = require"mythemes"

if awesome.startup_errors then
    libs.naughty.notify({ preset = libs.naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
    current_theme.play('logout')
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        current_theme.play('logout')
        libs.naughty.notify({ preset = libs.naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

return true