# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **dotfiles repository** for macOS development environment management using GNU Stow. It tracks configuration files for shell (zsh), editor (Neovim), terminal multiplexer (tmux), window manager (AeroSpace), and package management (Homebrew).

## Repository Architecture

### GNU Stow Pattern
Each top-level directory represents a "package" that mirrors the target home directory structure:

```
package_name/.target/path/config_file
```

Example: `zsh/.zshrc` stows to `~/.zshrc`
Example: `nvim/.config/nvim/init.lua` stows to `~/.config/nvim/init.lua`

### Key Packages
- **aerospace** - AeroSpace window manager (220-line TOML config with app launchers)
- **git** - Minimal Git config (uses `.gitconfig.local` pattern for machine-specific settings)
- **nvim** - Kickstart.nvim base with Tokyo Night theme, Terraform & Lua LSPs
- **tmux** - Relies on external gpakosz framework + custom `.tmux.conf.local`
- **zsh** - Oh My Zsh + Powerlevel10k (89KB `.p10k.zsh` customization)

### External Dependencies
This repo has mandatory external dependencies that must be installed separately:
- **Oh My Zsh** - Shell framework (manual install required)
- **gpakosz/.tmux** - tmux framework (`~/.tmux-gpakosz/` must be cloned)
- **Homebrew** - Package manager (all tools installed via Brewfile)

## Common Commands

### Installing Dotfiles on New Machine
```bash
# 1. Clone repo
git clone <repo-url> ~/.dotfiles && cd ~/.dotfiles

# 2. Install all Homebrew packages
brew bundle install

# 3. Symlink configs (requires GNU Stow)
stow aerospace git nvim tmux zsh

# 4. Install Oh-my-tmux framework
git clone https://github.com/gpakosz/.tmux.git ~/.tmux-gpakosz
ln -s -f ~/.tmux-gpakosz/.tmux.conf ~/.tmux.conf

# 5. Restart shell
exec zsh
```

### Managing Configurations

**Update Brewfile after installing new packages:**
```bash
brew bundle dump --describe --force
git add Brewfile
git commit -m "Update Brewfile"
```

**Add new configuration:**
```bash
# 1. Create Stow package structure
mkdir -p newapp/.config/newapp

# 2. Copy config
cp ~/.config/newapp/config newapp/.config/newapp/

# 3. Stow it
stow newapp
```

**Remove symlinks:**
```bash
stow -D package_name  # Unstow (remove symlinks)
```

**Reinstall symlinks:**
```bash
stow -R package_name  # Restow (remove + recreate symlinks)
```

### Testing Changes
```bash
# Test AeroSpace config reload
# In macOS: Alt+Shift+; then Escape

# Test tmux config
tmux source-file ~/.tmux.conf

# Test Neovim health
nvim -c :checkhealth
```

## Configuration Details

### Keybind Patterns
Current Vi-motion consistency across tools:
- **AeroSpace**: `Alt+HJKL` (window focus), `Alt+Shift+HJKL` (move windows)
- **tmux**: `Ctrl+HJKL` (pane navigation via vim-tmux-navigator)
- **Neovim**: Native `HJKL`, `Space` leader key

### Machine-Specific Overrides
Uses `.local` pattern for machine-specific settings (gitignored):
- `~/.gitconfig.local` - Email, name
- `~/.zshrc.local` - Machine-specific shell config
- `~/.tmux.conf.local.override` - Additional tmux overrides

## Package-Specific Details

### Neovim (nvim package)
- **Base**: Kickstart.nvim - single-file `init.lua` architecture
- **Theme**: Tokyo Night (`tokyonight-night` variant)
- **LSPs**: Terraform and Lua configured (via Mason)
- **Plugins**: Managed by lazy.nvim, `lazy-lock.json` is gitignored
- **Leader**: Space key
- **Custom dirs**: `lua/custom/plugins/` for user additions, `lua/kickstart/plugins/` from template

### AeroSpace (aerospace package)
- **App launchers**: `Shift-Ctrl-Alt-Cmd-Shift` + letter bindings (A=iTerm, B=Arc, C=Claude, D=Discord, M=Music, N=Obsidian, O=Outlook, P=Bitwarden, T=Teams)
- **Workspaces**: 1-5 assigned to main monitor, 6-10 assigned to secondary monitor
- **Floating windows**: Finder, Bitwarden, Teams, Outlook configured to float
- **Service mode**: `Alt+Shift+;` for config reload/reset operations

### tmux (tmux package)
- **Framework dependency**: Requires gpakosz repo at `~/.tmux-gpakosz/`
- **Config split**: Base is `~/.tmux.conf` (symlink to framework), customizations in `.tmux.conf.local`
- **Vi-mode**: Enabled
- **Custom binds**: `|` horizontal split, `-` vertical split
- **Plugin**: vim-tmux-navigator for seamless vim/tmux navigation

### Zsh (zsh package)
- **Files**: `.zshrc` (127 lines) + `.p10k.zsh` (89KB Powerlevel10k customization)
- **Framework**: Oh My Zsh with minimal plugins (only `git`)
- **Theme**: Powerlevel10k
- **FZF**: Integrated with `ag` (silver searcher) as default command
- **Aliases**: `inv` (nvim with fzf+bat picker), `vi` (nvim)

### Git (git package)
- Minimal base configuration
- Machine-specific settings (email, name) go in `~/.gitconfig.local` (gitignored)

## Current State vs Roadmap

**Currently Implemented:**
- Powerlevel10k theme (shell)
- Tokyo Night theme (Neovim)
- iTerm2 (terminal emulator - config not yet exported)
- gpakosz tmux framework
- Terraform & Lua LSPs only

**In Roadmap** (planned but not implemented):
- Starship prompt (alternative to Powerlevel10k)
- iTerm2 profile export
- Catppuccin theme (alternative theme option)
- Ghostty/WezTerm terminal emulators
- Additional LSPs (Python, JSON, YAML, Shell, Kubernetes)
- zoxide (smart directory navigation)
- atuin (shell history search)
- carapace (advanced completions)
- Shell vi-mode
- bootstrap.sh and install.sh scripts

## Troubleshooting Patterns

**Symlink conflicts**: Backup existing files before stowing
```bash
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

**AeroSpace config not loading**:
- Reload: `Alt+Shift+;` then `Escape`
- Or: `brew services restart aerospace`

**Neovim plugins broken**: `:checkhealth` then `:Lazy restore`

**tmux config not applying**: `tmux source-file ~/.tmux.conf` or `tmux kill-server`

## Development Workflow

When making changes to configs:
1. Edit files in `~/.dotfiles/package/` directory
2. Changes reflect immediately via symlinks
3. Test the config (see Testing Changes section)
4. Commit and push to repo

When adding new tools:
1. Install via Homebrew
2. Update Brewfile: `brew bundle dump --describe --force`
3. Create Stow package structure matching `~/.config/` or `~/` layout
4. Copy config files
5. Stow the package
6. Document in README.md if significant
