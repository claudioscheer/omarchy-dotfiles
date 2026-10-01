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

-- Workspace 4: floating, centered on the monitor that workspace is on.
o.window({ workspace = "4" }, { float = true, center = true })
-- KeePassXC is X11. It sends a ConfigureRequest for 0,0 after map, which overrides center.
o.window("^(KeePassXC)$", {
  workspace = "4",
  float = true,
  center = true,
  size = { 1040, 650 },
  no_screen_share = true,
  suppress_event = "x11configurerequest",
})

-- Docker TUI: launcher uses TUI.tile; Super+Shift+D uses org.omarchy.omarchy-launch-docker-tui.
o.window(
  "^(TUI\\.tile|org\\.omarchy\\.omarchy-launch-docker-tui)$",
  { workspace = "4", float = true, center = true }
)

-- Discord: native, Flatpak, or Chromium/Brave --app (class like chromium-discord.com__...).
-- Untag the --app window so the default chromium tile rule does not pin it tiled.
o.window("^.+-discord\\.com__.*$", { tag = "-chromium-based-browser" })
o.window(
  "(^(discord|Discord)$|^.+-discord\\.com__.*$|^com\\.discordapp\\.Discord$)",
  { workspace = "4", float = true, center = true }
)

-- Workspace 5: floating. OBS Studio, REAPER, and DaVinci Resolve.
o.window({ workspace = "5" }, { float = true, center = true })
o.window("^(obs|com\\.obsproject\\.Studio)$", { workspace = "5", float = true, center = true })
o.window("^REAPER$", { workspace = "5", float = true, no_anim = true })
-- Do not center every resolve window: context menus share this class.
-- Workspace 5 still centers the project window. Stock stay_focused pins dialogs.
o.window("^resolve$", { workspace = "5", float = true, fullscreen = false })
o.window(".*[Rr]esolve.*", { stay_focused = false })

-- File manager (Nautilus): float on whichever workspace is current.
o.window("^(org\\.gnome\\.Nautilus)$", { tag = "+floating-window" })

-- Omawrite, Omacalc, Omacut: same floating treatment as Nautilus.
o.window("^(omawrite|omacalc|omacut)$", { tag = "+floating-window" })

-- Workspace 10 (Super+0): floating. Android Studio, AVD emulator, and related qemu windows.
o.window({ workspace = "10" }, { float = true, center = true })
o.window(
  "(^(jetbrains-studio|Emulator)$|^qemu-system-|^Android Emulator$)",
  { workspace = "10", float = true, center = true }
)

-- Tiled apps last. Workspaces 4, 5, and 10 float whatever opens on them, and
-- the last matching static rule wins. These have to come after those rules
-- or a terminal opened from a floating workspace stays floating after it moves.
-- Workspace 1: browser, tiled (full size when it's the only window).
o.window("^(brave-browser)$", { workspace = "1", tile = true })

-- Workspace 2: Orca (Stably AI), tiled.
o.window("^(orca|Orca)$", { workspace = "2", tile = true })

-- Workspace 3: terminals and Omarchy agents, tiled.
o.window(
  "(Alacritty|kitty|com.mitchellh.ghostty|foot|org\\.codeberg\\.dnkl\\.foot|wezterm|org\\.omarchy\\.agent)",
  { workspace = "3", tile = true }
)

-- Workspace 8: Visual Studio Code, tiled.
o.window("^(Code|code)$", { workspace = "8", tile = true })

-- Workspace 9: Graphe (Bible study), tiled.
o.window("^(Graphe|graphe-bible)$", { workspace = "9", tile = true })

-- Any other window that opens floating (dialogs included) is centered on its monitor.
o.window({ float = true }, { center = true })

-- Main REAPER window only (title contains "REAPER v"). Maximized, not fullscreen.
-- The saved X11 size arrives after map, so the open hook sets maximize again.
o.window({ class = "^REAPER$", title = "REAPER v" }, {
  float = true,
  center = true,
  maximize = true,
  fullscreen = false,
  suppress_event = "x11configurerequest",
})

hl.on("window.open", function(w)
  if w.class ~= "REAPER" then
    return
  end
  local title = w.title or ""
  if not title:find("REAPER v", 1, true) then
    return
  end
  hl.dispatch(hl.dsp.window.fullscreen({
    mode = "maximized",
    action = "set",
    window = w,
  }))
end)

-- REAPER menus (title "menu") and tooltips (empty title) are separate X11 windows.
-- Centering or focusing them makes the menu bar draw broken popups.
-- https://github.com/hyprwm/Hyprland/issues/2278
o.window({ class = "^REAPER$", title = "^(menu)?$" }, {
  float = true,
  center = false,
  maximize = false,
  no_focus = true,
  no_anim = true,
  no_follow_mouse = true,
})

-- Resolve menus and tooltips use the same X11 titles. Must stay below the
-- float-centering rule so center = false wins.
o.window({ class = "^resolve$", title = "^(menu)?$" }, {
  float = true,
  center = false,
  maximize = false,
  fullscreen = false,
  no_focus = true,
  no_anim = true,
  no_follow_mouse = true,
})
