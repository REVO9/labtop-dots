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
