local themes = {}

local awful = require"awful"
local const = require("constants")

themes.Chicago = {
    wallpaper = "art/chicago.png",
    startup_sound = "sounds/startup_chicago.wav"
}

themes.Hypnos = {
    wallpaper = "art/hypnos.jpg",
    startup_sound = "sounds/startup.wav",
    window_open = "sounds/openwindow.wav",
    window_close = "sounds/close.wav",
    logout = "sounds/alert_window.wav",
    alert = "sounds/alert_window.wav"
}

--

themes.current_theme = themes.Hypnos

function themes.set_current_theme(name)
    themes.current_theme = themes
end

function themes.play(name)
    if not themes.current_theme[name] then
        return
    end

    awful.spawn( "aplay "..const.workspace..themes.current_theme[name],false )
end

return themes