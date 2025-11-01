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

echo "✅ Done!"
echo ""
echo "Next steps:"
echo "  1. Restart your shell: exec zsh"
echo "  2. Reload AeroSpace: Alt+Shift+; then Escape"
echo "  3. Create ~/.gitconfig.local for machine-specific git settings"
