# dotfiles

Personal development environment configuration for macOS. Tracks shell, editor, window manager, and tool configurations for rapid setup on new machines.

## Philosophy

- **Composable**: Each tool does one thing well
- **Understandable**: Read every line, know what it does
- **Vi-everywhere**: Consistent keybinds across shell, editor, window manager
- **Minimal dependencies**: GNU Stow for symlinking, Homebrew for packages

## What's Included

### Core Configs
- **zsh** - Shell with Oh My Zsh, Powerlevel10k theme, modern CLI tools (zoxide, atuin, carapace, fzf)
- **nvim** - Neovim with Kickstart base, Tokyo Night theme, Terraform & Lua LSPs
- **tmux** - Terminal multiplexer with gpakosz Oh-my-tmux framework
- **ghostty** - GPU-accelerated terminal emulator with transparency and blur effects
- **git** - Git configuration
- **aerospace** - AeroSpace tiling window manager for macOS

### Package Management
- **Brewfile** - All Homebrew packages, casks, and fonts

## Quick Start

### Automated Installation (Recommended)

```bash
# Clone this repo
git clone https://github.com/jonhill90/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run the install script
./install.sh

# Install Oh-my-tmux (gpakosz framework)
git clone https://github.com/gpakosz/.tmux.git ~/.tmux-gpakosz
ln -s -f ~/.tmux-gpakosz/.tmux.conf ~/.tmux.conf

# Restart your shell
exec zsh

# Reload AeroSpace config
# Press: Alt+Shift+; then Escape
```

The `install.sh` script will:
- Install Homebrew packages from Brewfile
- Install GNU Stow if needed
- Create all symlinks automatically

### Manual Installation

If you prefer to do it step by step:

1. **Prerequisites**
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
xcode-select --install
```

2. **Clone and install packages**
```bash
git clone https://github.com/jonhill90/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
brew bundle install
```

3. **Create symlinks with GNU Stow**
```bash
# IMPORTANT: Must use explicit --target for reliability
stow --target="$HOME" git zsh tmux aerospace nvim ghostty

# Verify symlinks were created
ls -la ~ | grep -E "gitconfig|zshrc|tmux|aerospace"
ls -la ~/.config/ | grep ghostty
# Look for 'l' at start and '->' arrow
```

4. **Install Oh-my-tmux**
```bash
git clone https://github.com/gpakosz/.tmux.git ~/.tmux-gpakosz
ln -s -f ~/.tmux-gpakosz/.tmux.conf ~/.tmux.conf
```

5. **Restart shell**
```bash
exec zsh
```

## Directory Structure

```
~/.dotfiles/
├── aerospace/
│   └── .aerospace.toml         # AeroSpace window manager config
├── git/
│   └── .gitconfig              # Git configuration
├── ghostty/.config/ghostty/
│   └── config                  # Ghostty terminal config
├── nvim/.config/nvim/
│   ├── init.lua                # Kickstart.nvim main config
│   ├── lua/                    # Lua modules
│   └── lazy-lock.json          # Plugin versions (gitignored)
├── tmux/
│   └── .tmux.conf.local        # gpakosz Oh-my-tmux customizations
├── zsh/
│   ├── .zshrc                  # Zsh config with Oh My Zsh
│   └── .p10k.zsh               # Powerlevel10k theme config
├── Brewfile                     # All Homebrew packages
├── install.sh                   # Automated setup script
├── .gitignore
└── README.md
```

**How GNU Stow maps these to your home directory:**
```
dotfiles/git/.gitconfig              → ~/.gitconfig
dotfiles/zsh/.zshrc                  → ~/.zshrc
dotfiles/zsh/.p10k.zsh               → ~/.p10k.zsh
dotfiles/tmux/.tmux.conf.local       → ~/.tmux.conf.local
dotfiles/aerospace/.aerospace.toml   → ~/.aerospace.toml
dotfiles/nvim/.config/nvim/          → ~/.config/nvim/
dotfiles/ghostty/.config/ghostty/    → ~/.config/ghostty/
```

The package name (first directory) is stripped, everything after mirrors your home directory.

## Tool Details

### Shell (zsh)
- **Framework**: Oh My Zsh
- **Theme**: Powerlevel10k (heavily customized 89KB config)
- **Modern CLI Tools**:
  - **zoxide** - Smart directory jumping (frecency-based `cd` replacement)
  - **atuin** - Searchable shell history with SQLite backend and sync
  - **carapace** - Advanced tab completions with descriptions for 1000+ commands
  - **fzf** - Fuzzy finder with ag (silver searcher) integration
- **Editor**: nvim (local), vim (SSH)
- **Aliases**:
  - `inv` - Open nvim with fzf file picker and bat preview
  - `vi` - Alias to nvim
  - `z` - Jump to directory (zoxide)
  - `zi` - Interactive directory selection (zoxide + fzf)

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
- **Framework**: gpakosz Oh-my-tmux (external dependency at `~/.tmux-gpakosz/`)
- **Config**: `.tmux.conf.local` for customizations (main `.tmux.conf` is symlinked to framework)
- **Vi-mode**: Enabled for copy mode
- **Pane splits**:
  - `prefix -` - Horizontal split (top/bottom panes)
  - `prefix _` - Vertical split (left/right panes)
- **Navigation**:
  - `Ctrl+HJKL` - Seamless navigation between vim and tmux panes (vim-tmux-navigator)
  - `prefix HJKL` - Select panes (gpakosz vi-style, repeatable)
  - `prefix Shift+HJKL` - Resize panes (gpakosz)
- **Plugins**: vim-tmux-navigator (managed by TPM)

### Git
- Minimal configuration tracked
- Machine-specific settings (email, name) should go in `~/.gitconfig.local` (gitignored)

### Terminal Emulator (Ghostty)
- **GPU-accelerated** - Fast rendering with Metal/OpenGL
- **Font**: FiraCode Nerd Font at 16pt with font-thicken enabled
- **Appearance**:
  - Background opacity: 0.9 with blur enabled
  - Display-P3 color space for vibrant colors
  - Custom macOS dock icon (black screen, white ghost)
  - Tab bar hidden (using tmux for multiplexing)
- **Theme**: iTerm2 Default
- **Config location**: `~/.config/ghostty/config` (XDG standard)

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

3. Stow it with explicit target:
```bash
stow --target="$HOME" newapp
```

4. Verify the symlink:
```bash
ls -la ~/.config/newapp
# Should show 'l' at start and '->' arrow
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
- zoxide - Smart directory jumping
- atuin - Shell history manager
- carapace - Advanced completions
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

### Recently Added
- [x] zoxide (smart directory navigation)
- [x] atuin (shell history search)
- [x] carapace (advanced completions)

### Planned (Future Projects)
- [ ] Starship prompt (alternative to Powerlevel10k)
- [ ] iTerm2 profile export
- [ ] Zsh vi-mode configuration
- [ ] Additional LSPs (Python, JSON, YAML, Shell, Kubernetes)

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

# Re-stow with explicit target
cd ~/.dotfiles
stow --target="$HOME" zsh

# Verify it worked
ls -la ~ | grep zshrc
# Should show: lrwxr-xr-x ... .zshrc -> .dotfiles/zsh/.zshrc
```

### Stow conflicts with existing files
```bash
# Backup the conflicting file first
mv ~/.zshrc ~/.zshrc.backup

# Then stow
cd ~/.dotfiles
stow --target="$HOME" zsh
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
