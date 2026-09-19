-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
-- Catch-all for any other output. Pin 1x; "auto" scale is ~1.5 on this 1080p panel.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Internal 15.6" panel. Stays at origin so unplugging HDMI does not leave a gap.
hl.monitor({ output = "eDP-1", mode = "1920x1080@300", position = "0x0", scale = 1 })

-- Dell P2422HE on HDMI, left of the laptop.
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto-left", scale = 1 })

-- External USB-C DisplayPort (NVIDIA DP-1). Same layout if HDMI is unused.
hl.monitor({ output = "DP-1", mode = "preferred", position = "auto-right", scale = 1 })
