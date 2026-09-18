#!/usr/bin/env bash
# Install these Omarchy user overrides onto the current machine.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_file() {
  local src="$1"
  local dest="$2"
  local mode="${3:-}"

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  if [[ -n $mode ]]; then
    chmod "$mode" "$dest"
  fi
  printf 'installed %s\n' "$dest"
}

install_file "$ROOT/config/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"
install_file "$ROOT/config/hypr/monitors.lua" "$HOME/.config/hypr/monitors.lua"
install_file "$ROOT/config/hypr/autostart.lua" "$HOME/.config/hypr/autostart.lua"
install_file "$ROOT/config/omarchy/shell.json" "$HOME/.config/omarchy/shell.json"
install_file "$ROOT/config/omarchy/defaults/agent" "$HOME/.config/omarchy/defaults/agent"
install_file "$ROOT/config/environment.d/10-ssh-agent.conf" "$HOME/.config/environment.d/10-ssh-agent.conf"
install_file "$ROOT/config/uwsm/env.d/20-ssh-agent" "$HOME/.config/uwsm/env.d/20-ssh-agent" 700

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null
  hyprctl configerrors
fi

echo
echo "Done. New terminals/agents/Brave/KeePass follow the workspace rules after they next open."
echo "If the laptop panel is not eDP-1 (hybrid GPU mux), edit ~/.config/hypr/monitors.lua."
echo "KeePassXC is not installed by this script: omarchy pkg add keepassxc"
