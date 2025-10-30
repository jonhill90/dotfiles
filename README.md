# dotfiles

Personal development environment configuration for macOS. Tracks shell, editor, window manager, and tool configurations for rapid setup on new machines.

## Philosophy

- **Composable**: Each tool does one thing well
- **Understandable**: Read every line, know what it does
- **Vi-everywhere**: Consistent keybinds across shell, editor, window manager
- **Minimal dependencies**: GNU Stow for symlinking, Homebrew for packages

## What's Included

### Core Configs
- **zsh** - Shell with Oh My Zsh, Powerlevel10k theme, FZF integration
- **nvim** - Neovim with Kickstart base, Tokyo Night theme, Terraform & Lua LSPs
- **tmux** - Terminal multiplexer with gpakosz Oh-my-tmux framework
- **git** - Git configuration
- **aerospace** - AeroSpace tiling window manager for macOS

### Package Management
- **Brewfile** - All Homebrew packages, casks, and fonts

## Quick Start

### Prerequisites
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git (via Homebrew or Xcode Command Line Tools)
xcode-select --install
```

### Installation

1. Clone this repo:
```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install packages from Brewfile:
```bash
brew bundle install
```

3. Symlink configurations using GNU Stow:
```bash
# Install Stow
brew install stow

# Symlink all configs
stow aerospace git nvim tmux zsh

# Or symlink individually
stow zsh      # Creates ~/.zshrc and ~/.p10k.zsh
stow nvim     # Creates ~/.config/nvim/
stow git      # Creates ~/.gitconfig
stow aerospace # Creates ~/.config/aerospace/aerospace.toml
stow tmux     # Creates ~/.tmux.conf.local
```

4. Install Oh-my-tmux (gpakosz framework):
```bash
cd
git clone https://github.com/gpakosz/.tmux.git ~/.tmux-gpakosz
ln -s -f ~/.tmux-gpakosz/.tmux.conf ~/.tmux.conf
# Your .tmux.conf.local is already symlinked from dotfiles
```

5. Restart your shell:
```bash
exec zsh
```

## Directory Structure

```
~/.dotfiles/
├── aerospace/.config/aerospace/
│   └── aerospace.toml          # AeroSpace window manager config
├── git/
│   └── .gitconfig              # Git configuration
├── nvim/.config/nvim/
│   ├── init.lua                # Kickstart.nvim main config
│   ├── lua/                    # Lua modules
│   └── lazy-lock.json          # Plugin versions (gitignored)
├── tmux/
│   ├── tmux.conf               # Basic tmux config
│   └── .tmux.conf.local        # gpakosz customizations
├── zsh/
│   ├── .zshrc                  # Zsh config with Oh My Zsh
│   └── .p10k.zsh               # Powerlevel10k theme config
├── Brewfile                     # All Homebrew packages
├── .gitignore
└── README.md
```

## Tool Details

### Shell (zsh)
- **Framework**: Oh My Zsh
- **Theme**: Powerlevel10k (heavily customized 89KB config)
- **Integrations**: FZF with ag (silver searcher)
- **Editor**: nvim (local), vim (SSH)
- **Aliases**:
  - `inv` - Open nvim with fzf file picker and bat preview
  - `vi` - Alias to nvim

### Editor (Neovim)
- **Base**: Kickstart.nvim (TJ DeVries' template)
- **Plugin Manager**: lazy.nvim
- **Theme**: Tokyo Night (tokyonight-night variant)
- **LSP Servers** (via Mason):
  - terraform - Terraform/HCL
  - lua_ls - Lua
- **Key Plugins**:
  - Telescope - Fuzzy finder
  - Treesitter - Syntax highlighting
  - blink.cmp - Completion
  - LuaSnip - Snippets
  - neo-tree - File explorer
  - gitsigns - Git integration
  - conform.nvim - Formatting (stylua)
- **Leader Key**: Space

### Window Manager (AeroSpace)
- **Navigation**: Vi-style (Alt+HJKL)
- **Layouts**: Tiles (Alt+/) and Accordion (Alt+,)
- **Workspaces**:
  - 1-5 on main monitor
  - 6-10 on secondary monitor
- **App Launchers** (Shift-Ctrl-Alt-Cmd-Shift + key):
  - A: iTerm
  - B: Arc browser
  - C: Claude
  - D: Discord
  - M: Music
  - N: Obsidian
  - O: Outlook
  - P: Bitwarden
  - T: Teams
- **Floating Apps**: Finder, Bitwarden, Teams, Outlook

### Terminal Multiplexer (tmux)
- **Framework**: gpakosz Oh-my-tmux
- **Vi-mode**: Enabled
- **Custom splits**:
  - `|` - Horizontal split
  - `-` - Vertical split
- **Plugin**: vim-tmux-navigator (Ctrl+HJKL navigation between vim and tmux)

### Git
- Minimal configuration tracked
- Machine-specific settings (email, name) should go in `~/.gitconfig.local` (gitignored)

## Keybind Philosophy

**Vi motions everywhere:**
- AeroSpace: Alt+HJKL for window focus
- tmux: Ctrl+HJKL for pane navigation (with vim-tmux-navigator)
- Neovim: Native HJKL
- Shell: (future) Vi-mode in zsh

**Shift for movement:**
- AeroSpace: Alt+Shift+HJKL moves windows
- tmux: Vim-style pane management

**Space leader:**
- Neovim: Space as leader key
- Consistent muscle memory

## Shortcuts Reference

Comprehensive keybinding documentation organized by importance (Essential → Common → Advanced):

- **[tmux Shortcuts](docs/tmux-shortcuts.md)** - Complete tmux keybindings including gpakosz Oh-my-tmux framework shortcuts
- **[Neovim Shortcuts](docs/nvim-shortcuts.md)** - Complete Neovim/Kickstart keybindings including LSP, Telescope, and plugins

## Customization

### Machine-Specific Overrides

Create local config files (gitignored):
```bash
# Git
~/.gitconfig.local

# Zsh
~/.zshrc.local

# Tmux
~/.tmux.conf.local.override
```

### Adding New Configs

1. Create directory structure matching target path:
```bash
mkdir -p newapp/.config/newapp
```

2. Add config file:
```bash
cp ~/.config/newapp/config newapp/.config/newapp/
```

3. Stow it:
```bash
stow newapp
```

## Maintenance

### Update Brewfile
```bash
cd ~/.dotfiles
brew bundle dump --describe --force
git add Brewfile
git commit -m "Update Brewfile"
```

### Update Neovim Plugins
```bash
# In Neovim
:Lazy update
```

### Update Oh My Zsh
```bash
omz update
```

## Dependencies

### Via Homebrew
See `Brewfile` for complete list. Key tools:
- neovim
- tmux
- fzf
- the_silver_searcher (ag)
- bat
- stow
- aerospace
- iterm2
- powerlevel10k

### Manual Installs
- Oh My Zsh: https://ohmyz.sh/
- gpakosz tmux: https://github.com/gpakosz/.tmux

## Roadmap

### Planned (Future Projects)
- [ ] Starship prompt (alternative to Powerlevel10k)
- [ ] iTerm2 profile export
- [ ] Zsh vi-mode configuration
- [ ] Additional LSPs (Python, JSON, YAML, Shell, Kubernetes)
- [ ] zoxide (smart directory navigation)
- [ ] atuin (shell history search)
- [ ] carapace (advanced completions)

### Out of Scope
- macOS system preferences (manual setup)
- Secrets management (use 1Password)
- SSH keys (manual, never commit private keys)
- IDE configs beyond Neovim

## Troubleshooting

### Symlinks not working
```bash
# Check what's already there
ls -la ~/

# Remove existing files (backup first!)
mv ~/.zshrc ~/.zshrc.backup

# Re-stow
cd ~/.dotfiles
stow zsh
```

### AeroSpace not loading config
```bash
# Reload config
# Press: Alt+Shift+; then Escape

# Or restart AeroSpace
brew services restart aerospace
```

### Neovim plugins not loading
```bash
# In Neovim, check health
:checkhealth

# Reinstall plugins
:Lazy restore
```

### tmux config not applying
```bash
# Source config
tmux source-file ~/.tmux.conf

# Or restart tmux
tmux kill-server
tmux
```

## License

MIT

## Related Projects

- [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) - Neovim base config
- [Oh my tmux!](https://github.com/gpakosz/.tmux) - tmux framework
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) - macOS tiling window manager
