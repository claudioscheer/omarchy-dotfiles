# Omarchy user overrides

Stock Omarchy files are **not** here. This repo is only the personal overlay used on this machine, so a fresh Omarchy install can be made to match.

Restore:

```bash
cd ~/Projects/omarchy-dotfiles
./install.sh
```

Then install KeePassXC if it is missing: `omarchy pkg add keepassxc`.

## Layout

| Workspace | Apps | Behavior |
|---|---|---|
| 1 (`Super+1`) | Brave | Tiled. Full size when it is the only window |
| 2 (`Super+2`) | Orca (Stably AI) | Tiled |
| 3 (`Super+3`) | Alacritty / other terminals, `org.omarchy.agent` | Tiled |
| 4 (`Super+4`) | KeePassXC, Discord (native or web app), anything else opened here | Floating |
| 5 (`Super+5`) | OBS Studio | Tiled |
| 6–10 (`Super+6` … `Super+0`) | Unassigned | Persistent empty workspaces; tiled by default |

Move a floating window with `Super` + left drag. Resize with `Super` + right drag. `Super+T` still floats or tiles one window.

## Keyboard

Two US layouts (same physical keys). Switch with Left Alt + Right Alt, or the bar layout label.

| Layout | Variant | Bar label | Behavior |
|---|---|---|---|
| US (first) | default | EN | Plain English. `'` is an apostrophe. Super+… binds stay on QWERTY |
| US (second) | `intl` | PT | Dead keys. `'` then `c` is ç (`~/.XCompose` overrides locale ć) |

The short bar label for the intl tooltip is remapped to PT in `~/.config/omarchy/shell.json`. This laptop has more than one keyboard device, so the label follows the tooltip of the device the widget is watching.

## Touchpad

Toggle with `touchpad` (or `omarchy toggle touchpad`). `touchpad on` / `touchpad off` set it. The laptop Fn touchpad key also works.

## Files

| Path in repo | Installs to |
|---|---|
| `config/hypr/hyprland.lua` | Workspace and window rules |
| `config/hypr/monitors.lua` | Internal panel `eDP-1` at `1920x1080@300`, scale 1 |
| `config/hypr/input.lua` | US + US-intl layouts, compose on Caps |
| `config/hypr/autostart.lua` | `SSH_AUTH_SOCK` for the user ssh-agent |
| `config/XCompose` | Cedilla on `'c` plus identification compose sequences |
| `config/grok/skills/omarchy-dotfiles/SKILL.md` | Grok skill: always mirror live Omarchy edits into this repo |
| `config/omarchy/shell.json` | Transparent bar; US-intl layout labeled PT |
| `config/omarchy/plugins/water.keyboard-layout/` | Cloned bar widget; intl tooltip labeled PT |
| `config/omarchy/defaults/agent` | Default agent: `grok` |
| `config/environment.d/10-ssh-agent.conf` | systemd user environment |
| `config/uwsm/env.d/20-ssh-agent` | Graphical session ssh-agent socket |
| `config/local/bin/touchpad` | Toggle the laptop touchpad (`touchpad` / `on` / `off`) |

Not copied: password databases, KeePass settings, SSH keys, themes that match stock Omarchy, Hyprland files that still match `/usr/share/omarchy/config/hypr/`.

## Monitor / GPU mux

This laptop is an ASUS ROG Strix G533ZM. Dedicated NVIDIA mux names the panel `eDP-1`. Hybrid Intel mux often names it `eDP-2`. The 300 Hz mode is ignored if the connector name is wrong and the panel falls back to 60 Hz.

After a mux change (`asusctl armoury set gpu_mux_mode 0` or `1`, then reboot), update the `output` in `~/.config/hypr/monitors.lua` and `hyprctl reload`.
