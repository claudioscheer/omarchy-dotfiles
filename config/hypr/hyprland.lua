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

-- Keep workspaces 1-10 alive so Super+1..0 and the bar always have them.
for workspace = 1, 10 do
  hl.workspace_rule({ workspace = tostring(workspace), persistent = true })
end

-- Workspace 1: browser, tiled (full size when it's the only window).
o.window("^(brave-browser)$", { workspace = "1", tile = true })

-- Workspace 2: Orca (Stably AI), tiled.
o.window("^(orca|Orca)$", { workspace = "2", tile = true })

-- Workspace 3: terminals and Omarchy agents, tiled.
o.window(
  "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm|org\\.omarchy\\.agent)",
  { workspace = "3", tile = true }
)

-- Workspace 4: floating. KeePass always opens here.
o.window({ workspace = "4" }, { float = true })
o.window("^(KeePassXC)$", { workspace = "4", float = true, no_screen_share = true })

-- Docker TUI: launcher uses TUI.tile; Super+Shift+D uses org.omarchy.omarchy-launch-docker-tui.
o.window(
  "^(TUI\\.tile|org\\.omarchy\\.omarchy-launch-docker-tui)$",
  { workspace = "4", float = true }
)

-- Discord: native, Flatpak, or Chromium/Brave --app (class like chromium-discord.com__...).
-- Untag the --app window so the default chromium tile rule does not pin it tiled.
o.window("^.+-discord\\.com__.*$", { tag = "-chromium-based-browser" })
o.window(
  "(^(discord|Discord)$|^.+-discord\\.com__.*$|^com\\.discordapp\\.Discord$)",
  { workspace = "4", float = true }
)

-- Workspace 5: OBS Studio, tiled.
o.window("^(obs|com\\.obsproject\\.Studio)$", { workspace = "5", tile = true })

-- Workspace 9: Graphe (Bible study), tiled.
o.window("^(Graphe|graphe-bible)$", { workspace = "9", tile = true })

-- File manager (Nautilus): float on whichever workspace is current.
o.window("^(org\\.gnome\\.Nautilus)$", { tag = "+floating-window" })

-- Workspace 10 (Super+0): floating. Android Studio, AVD emulator, and related qemu windows.
o.window({ workspace = "10" }, { float = true })
o.window(
  "(^(jetbrains-studio|Emulator)$|^qemu-system-|^Android Emulator$)",
  { workspace = "10", float = true }
)
