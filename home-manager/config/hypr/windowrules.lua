-- extra blur layers
hl.layer_rule({ name = "blur", match = { namespace = "wofi" } })
hl.layer_rule({ name = "blur", match = { namespace = "waybar" } })

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

-- idle inhibit
hl.window_rule({
    name = "idle_inhibit_fullscreen",
    match = { class = ".*" },
    idle_inhibit = "fullscreen"
})

hl.window_rule({
    name = "idle_inhibit_focus",
    match = { title = "^(YouTube)$" },
    idle_inhibit = "focus"
})

hl.window_rule({
    name = "idle_inhibit_always",
    match = { title = "^(cava)$" },
    idle_inhibit = "always"
})

hl.window_rule({
    name = "no_initial_focus_krita",
    match = { class = "[Kk]rita" },
    no_initial_focus = true
})

-- steam big picture mode
hl.window_rule({
    name = "steam_big_picture",
    match = { title = "Steam Big Picture Mode" },
    fullscreen = true,
    rounding = 0,
    border_size = 0,
    no_anim = true,
    no_shadow = true
})

-- opacity
hl.window_rule({
    name = "opacity_librewolf",
    match = { class = "^(librewolf)$", fullscreen = false },
    opacity = 0.85
})

hl.window_rule({
    name = "opacity_youtube",
    match = { title = "^.*(YouTube).*$", fullscreen = false },
    opacity = "1.0 0.85"
})

hl.window_rule({
    name = "opacity_thunar",
    match = { class = "^([Tt]hunar)$", fullscreen = false },
    opacity = 0.85
})

hl.window_rule({
    name = "opacity_vesktop",
    match = { class = "^(vesktop)$", fullscreen = false },
    opacity = 0.85
})

hl.window_rule({
    name = "opacity_steam",
    match = { title = "^(Steam)$", fullscreen = false },
    opacity = 0.8
})

hl.window_rule({
    name = "opacity_libreoffice",
    match = { class = "^(libreoffice).*$", fullscreen = false },
    opacity = 0.8
})
