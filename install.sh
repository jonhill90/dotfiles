#!/usr/bin/env bash

set -e

cd ~/.dotfiles || exit 1

echo "🚀 Installing dotfiles..."

# Install packages if on Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "📦 Installing Homebrew packages..."
  brew bundle install
fi

# Install GNU Stow if not present
if ! command -v stow &> /dev/null; then
  echo "📌 Installing GNU Stow..."
  brew install stow
fi

# Stow all packages with explicit target
echo "🔗 Creating symlinks..."
stow --target="$HOME" git zsh tmux aerospace nvim

# VSCode requires OS-specific symlinking (can't use stow)
echo "🔗 Setting up VSCode configs..."
if [[ "$OSTYPE" == "darwin"* ]]; then
  VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  VSCODE_USER_DIR="$HOME/.config/Code/User"
else
  echo "⚠️  Unsupported OS for VSCode setup: $OSTYPE"
  VSCODE_USER_DIR=""
fi

if [ -n "$VSCODE_USER_DIR" ]; then
  mkdir -p "$VSCODE_USER_DIR"

  # Backup existing configs if they're not symlinks
  if [ -f "$VSCODE_USER_DIR/settings.json" ] && [ ! -L "$VSCODE_USER_DIR/settings.json" ]; then
    mv "$VSCODE_USER_DIR/settings.json" "$VSCODE_USER_DIR/settings.json.backup-$(date +%Y%m%d-%H%M%S)"
  fi

  if [ -f "$VSCODE_USER_DIR/keybindings.json" ] && [ ! -L "$VSCODE_USER_DIR/keybindings.json" ]; then
    mv "$VSCODE_USER_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json.backup-$(date +%Y%m%d-%H%M%S)"
  fi

  # Create symlinks
  ln -sf "$HOME/.dotfiles/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
  ln -sf "$HOME/.dotfiles/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"

  echo "  ✓ VSCode configs symlinked"
fi

echo "✅ Done!"
echo ""
echo "Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Reload AeroSpace: Alt+Shift+; then Escape"
echo "  3. Create ~/.gitconfig.local for machine-specific git settings"
