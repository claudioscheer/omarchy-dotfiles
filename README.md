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
| 2 (`Super+2`) | Alacritty / other terminals, `org.omarchy.agent` | Tiled |
| 3 (`Super+3`) | KeePassXC, anything else opened here | Floating |
| 5 (`Super+5`) | OBS Studio | Tiled |

Move a floating window with `Super` + left drag. Resize with `Super` + right drag. `Super+T` still floats or tiles one window.

## Files

| Path in repo | Installs to |
|---|---|
| `config/hypr/hyprland.lua` | Workspace and window rules |
| `config/hypr/monitors.lua` | Internal panel `eDP-1` at `1920x1080@300`, scale 1 |
| `config/hypr/autostart.lua` | `SSH_AUTH_SOCK` for the user ssh-agent |
| `config/omarchy/shell.json` | Transparent bar |
| `config/omarchy/defaults/agent` | Default agent: `grok` |
| `config/environment.d/10-ssh-agent.conf` | systemd user environment |
| `config/uwsm/env.d/20-ssh-agent` | Graphical session ssh-agent socket |

Not copied: password databases, KeePass settings, SSH keys, themes that match stock Omarchy, Hyprland files that still match `/usr/share/omarchy/config/hypr/`.

## Monitor / GPU mux

This laptop is an ASUS ROG Strix G533ZM. Dedicated NVIDIA mux names the panel `eDP-1`. Hybrid Intel mux often names it `eDP-2`. The 300 Hz mode is ignored if the connector name is wrong and the panel falls back to 60 Hz.

After a mux change (`asusctl armoury set gpu_mux_mode 0` or `1`, then reboot), update the `output` in `~/.config/hypr/monitors.lua` and `hyprctl reload`.
