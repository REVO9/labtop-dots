---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. "+ Q", hl.dsp.exec_cmd(Terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + U",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + M", ToggleMirror)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(FileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(Menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + s", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen("toggle"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

for i = 1, 6 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(mainMod .. "+  SHIFT + S", hl.dsp.exec_cmd("~/.scripts/screenshot.sh"))
hl.bind(mainMod .. "+  SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind(mainMod .. "+ Z", hl.dsp.dpms("toggle"))

hl.config({
    plugin = {
        hyprgrass = {
            sensitivity = 4.0,

            long_press_delay = 400,

            resize_on_border_long_press = true,

            edge_margin = 10,
        }
    }
})

-- swipe down from left edge
hl.plugin.hyprgrass.bind {
    pattern = { kind = "edge", origin = "r", direction = "d", },
    action = hl.dsp.exec_cmd(" pactl set-sink-volume @DEFAULT_SINK@ -4%")
}
hl.plugin.hyprgrass.bind {
    pattern = { kind = "edge", origin = "r", direction = "u", },
    action = hl.dsp.exec_cmd(" pactl set-sink-volume @DEFAULT_SINK@ +4%")
}

hl.plugin.hyprgrass.bind {
    pattern = { kind = "edge", origin = "l", direction = "r", },
    action = hl.dsp.exec_cmd("kill -34 $(pidof wvkbd-mobintl)")
}

hl.plugin.hyprgrass.bind {
    pattern = { kind = "edge", origin = "r", direction = "l", },
    action = hl.dsp.exec_cmd("swaync-client -t")
}

-- hyprgrass-bind = , edge:u:d, exec, hyprctl keyword monitor ,preferred,auto,auto,transform,2
-- hyprgrass-bind = , edge:d:u, exec, hyprctl keyword monitor ,preferred,auto,auto,transform,0

hl.config {
    gestures = {
        workspace_swipe_touch = true,
        workspace_swipe_cancel_ratio = 0.15,
    }
}

hl.plugin.hyprgrass.gesture {
    pattern = { kind = "swipe", fingers = 3, direction = "horizontal", },
    action = "workspace"
}
hl.plugin.hyprgrass.gesture {
    pattern = { kind = "pinch", fingers = 3, direction = "pinchout", },
    action = "close"
}
hl.plugin.hyprgrass.gesture {
    pattern = { kind = "swipe", fingers = 4, direction = "u", },
    action = function()
        hl.dispatch(hl.dsp.exec_cmd("kill -USR2 $(pidof wvkbd-mobintl) && " .. Menu))
    end
}
hl.plugin.hyprgrass.gesture {
    pattern = { kind = "pinch", fingers = 3, direction = "pinchin", },
    action = "fullscreen"
}
hl.plugin.hyprgrass.gesture {
    pattern = { kind = "swipe", fingers = 3, direction = "u", },
    action = "float"
}
