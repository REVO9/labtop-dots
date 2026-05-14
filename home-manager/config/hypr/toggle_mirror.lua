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
            hl.notification.create({ text = monitor.name, timeout = 10000 })
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
