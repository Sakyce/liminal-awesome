local constants = require"constants"
local libs = constants.libs

return {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = libs.beautiful.border_width,
                     border_color = libs.beautiful.border_normal,
                     focus = libs.awful.client.focus.filter,
                     raise = true,
                     --keys = clientkeys,
                     --buttons = clientbuttons,
                     screen = libs.awful.screen.preferred,
                     placement = libs.awful.placement.no_overlap+libs.awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "Firefox" }, properties = { fullscreen=true,titlebars_enabled = false } },
}