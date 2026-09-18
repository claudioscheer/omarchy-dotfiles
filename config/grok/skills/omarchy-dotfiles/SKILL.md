---
name: omarchy-dotfiles
description: >
  REQUIRED on this machine whenever customizing Omarchy, Hyprland, the bar,
  keyboard, XCompose, terminals, or ~/Projects/omarchy-dotfiles. After every
  live config change, mirror it into the personal overlay repo. Triggers:
  Hyprland, window rules, workspaces, input.lua, keyboard layout, XCompose,
  ~/.config/hypr, ~/.config/omarchy, omarchy-dotfiles, overlay, install.sh.
---

# Personal Omarchy overlay

Live `~/.config` edits are not enough. Restore source is
`~/Projects/omarchy-dotfiles` via `./install.sh`.

Use this together with the packaged Omarchy skill. Do not edit
`/usr/share/omarchy/` or the packaged skill under
`/usr/share/omarchy/default/agents/skills/omarchy/`.

## After every live change

1. Edit the live file (`~/.config/hypr/`, `~/.config/omarchy/`, `~/.XCompose`,
   `~/.config/environment.d/`, `~/.config/uwsm/`, terminal configs).
2. Write the same content into `~/Projects/omarchy-dotfiles/` at the path in
   that repo's README files table.
3. If the file is new to the overlay, add it to `install.sh` and the README
   files table.
4. Do not copy secrets, KeePass databases, SSH keys, or files that still match
   `/usr/share/omarchy` defaults.
5. Do not `git commit` unless the user asks.

Skip only for ephemeral actions: a one-off `hyprctl dispatch`, a reminder, or
`omarchy pkg` with no config file change.
