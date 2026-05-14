------------------
---- MONITORS ----
------------------

DefaultMonitor = "eDP-1"

hl.monitor({
    output   = DefaultMonitor,
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.on("config.reloaded", function()
    UpdateMirrorSilent()
end)

local MirrorMonitors = false
local MirroredMonitors = {}

function ToggleMirror()
    MirrorMonitors = not MirrorMonitors
    UpdateMirror()
end

function UpdateMirror()
    hl.dispatch(hl.dsp.exec_cmd(
        "notify-send 'mirror screen: "
        .. tostring(MirrorMonitors)
        .. "'"
    ))

    UpdateMirrorSilent()
end

function UpdateMirrorSilent()
    if not MirrorMonitors then
        for _, monitor in pairs(MirroredMonitors) do
            hl.monitor({
                output   = monitor,
                mode     = "preferred",
                position = "auto",
                mirror   = "",
            })
        end
        MirroredMonitors = {}
    else
        local monitors = hl.get_monitors()
        for _, monitor in pairs(monitors) do
            if monitor.name == DefaultMonitor then
                goto continue
            end

            hl.monitor({
                output   = monitor.name,
                mode     = "preferred",
                position = "auto",
                mirror   = DefaultMonitor,
            })

            table.insert(MirroredMonitors, monitor.name)

            ::continue::
        end
    end
end
