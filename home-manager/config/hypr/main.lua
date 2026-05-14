require("monitors")
require("windowrules")

Terminal    = "kitty"
FileManager = "thunar"
Menu        = "wofi"


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wvkbd-mobintl -L 180 --hidden")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("HYPRCURSOR_THEME", "Nordzy-cursors")
hl.env("WLR_DRM_NO_ATOMIC", "1")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({

    xwayland = {
        force_zero_scaling = true
    },

    general = {
        gaps_in = 3,
        gaps_out = 7,
        border_size = 2,
        col = {
            active_border = "rgba(E8B161ee)",
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",

        allow_tearing = true,
    },


    decoration = {
        rounding = 15,

        blur = {
            enabled = true,
            size = 8,
            passes = 2,
        },

        shadow = {
            enabled = false,
        },
    },

    animations = {
        enabled = true,

    },

    dwindle = {
        preserve_split = true
    },

    input = {
        kb_layout = "us",
        kb_variant = "altgr-intl",
    },
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 0.95 } } })

hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default", style = "slide" })

require("keybinds")
