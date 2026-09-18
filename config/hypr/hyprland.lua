-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Workspace 1: browser, tiled (full size when it's the only window).
o.window("^(brave-browser)$", { workspace = "1", tile = true })

-- Workspace 2: terminals and Omarchy agents, tiled.
o.window(
  "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm|org\\.omarchy\\.agent)",
  { workspace = "2", tile = true }
)

-- Workspace 3: floating. KeePass always opens here.
o.window({ workspace = "3" }, { float = true })
o.window("^(KeePassXC)$", { workspace = "3", float = true, no_screen_share = true })

-- Workspace 5: OBS Studio, tiled.
o.window("^(obs|com\\.obsproject\\.Studio)$", { workspace = "5", tile = true })
