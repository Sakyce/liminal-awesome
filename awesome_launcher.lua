local const = require"constants"
local libs = const.libs

myawesomemenu = {
    { "hotkeys", function()
        libs.hotkeys_popup.show_help(nil, libs.awful.screen.focused()) 
    end},
    { "manual", const.terminal .. " -e man awesome" },
    { "edit config", const.editor_cmd .. " " .. awesome.conffile },
    { "restart", function()
        libs.awful.util.spawn("cd ~/.config/awesome && gh repo sync") 
        awesome.restart() 
    end},
    { "quit", awesome.quit },
 }

mymainmenu = libs.awful.menu({
    items = { { "awesome", myawesomemenu, libs.beautiful.awesome_icon },
    { "open terminal", const.terminal }}
})

mylauncher = libs.awful.widget.launcher({ 
    image = libs.beautiful.awesome_icon,
    menu = mymainmenu 
})

libs.menubar.utils.terminal = const.terminal