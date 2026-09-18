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
install_file "$ROOT/config/hypr/input.lua" "$HOME/.config/hypr/input.lua"
install_file "$ROOT/config/hypr/autostart.lua" "$HOME/.config/hypr/autostart.lua"
install_file "$ROOT/config/hypr/looknfeel.lua" "$HOME/.config/hypr/looknfeel.lua"
install_file "$ROOT/config/XCompose" "$HOME/.XCompose"
install_file "$ROOT/config/grok/skills/omarchy-dotfiles/SKILL.md" "$HOME/.grok/skills/omarchy-dotfiles/SKILL.md"
install_file "$ROOT/config/omarchy/shell.json" "$HOME/.config/omarchy/shell.json"
install_file "$ROOT/config/omarchy/plugins/water.keyboard-layout/manifest.json" "$HOME/.config/omarchy/plugins/water.keyboard-layout/manifest.json"
install_file "$ROOT/config/omarchy/plugins/water.keyboard-layout/KeyboardLayout.qml" "$HOME/.config/omarchy/plugins/water.keyboard-layout/KeyboardLayout.qml"
install_file "$ROOT/config/omarchy/plugins/water.keyboard-layout/KeyboardLayoutModel.js" "$HOME/.config/omarchy/plugins/water.keyboard-layout/KeyboardLayoutModel.js"
install_file "$ROOT/config/omarchy/defaults/agent" "$HOME/.config/omarchy/defaults/agent"
install_file "$ROOT/config/environment.d/10-ssh-agent.conf" "$HOME/.config/environment.d/10-ssh-agent.conf"
install_file "$ROOT/config/uwsm/env.d/20-ssh-agent" "$HOME/.config/uwsm/env.d/20-ssh-agent" 700
install_file "$ROOT/config/local/bin/touchpad" "$HOME/.local/bin/touchpad" 755

# Interactive shell is omarchy-zsh (https://github.com/omacom/omarchy-zsh).
# Stock templates first, then this overlay's ~/.zshrc (history autosuggestions).
if command -v omarchy >/dev/null 2>&1; then
  omarchy pkg add omarchy-zsh || true
fi
if command -v omarchy-setup-zsh >/dev/null 2>&1; then
  omarchy-setup-zsh
fi
install_file "$ROOT/config/zshrc" "$HOME/.zshrc"

if [[ ! -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && ! -f $HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  mkdir -p "$HOME/.local/share/zsh"
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$HOME/.local/share/zsh/zsh-autosuggestions"
fi

if command -v hyprctl >/dev/null 2>&1; then
  hyprctl reload >/dev/null
  hyprctl configerrors
fi

if command -v omarchy >/dev/null 2>&1; then
  omarchy restart xcompose >/dev/null 2>&1 || true
  omarchy-shell shell rescanPlugins >/dev/null 2>&1 || true
fi

echo
echo "Done. New terminals/agents/Brave/KeePass follow the workspace rules after they next open."
echo "If the laptop panel is not eDP-1 (hybrid GPU mux), edit ~/.config/hypr/monitors.lua."
echo "KeePassXC is not installed by this script: omarchy pkg add keepassxc"
echo "Login shell is zsh via omarchy-zsh. If it is still bash: chsh -s /usr/bin/zsh"
