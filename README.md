# dotfiles

macOS development environment with GNU Stow. Quick setup for shell, editor, window manager, and terminal.

## Philosophy

**Composable** · **Understandable** · **Vi-everywhere** · **Minimal**

## Stack

- **Shell**: zsh + Oh My Zsh + Powerlevel10k + modern CLI tools (zoxide, atuin, carapace, fzf)
- **Editor**: Neovim (LazyVim + Tokyo Night + Terraform/Lua LSPs) + VSCode (vscode-neovim integration)
- **Multiplexer**: tmux (minimal custom config + TPM plugins + Tokyo Night theme)
- **Terminal**: Ghostty (GPU-accelerated with transparency)
- **Window Manager**: AeroSpace (tiling for macOS)
- **Package Manager**: Homebrew (Brewfile tracks everything)

## Installation

```bash
# Clone to ~/.dotfiles
git clone https://github.com/jonhill90/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run automated installer
./install.sh

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload shell and start tmux
exec zsh
tmux
# In tmux: prefix + I to install plugins
# AeroSpace: Alt+Shift+; then Escape
```

**What install.sh does:**
- Installs Homebrew packages (Brewfile)
- Installs GNU Stow
- Creates all symlinks via Stow
- **Note**: TPM must be installed separately (see above)

**Manual steps** (if needed):
```bash
brew bundle install                                  # Install packages
stow --target="$HOME" git zsh tmux aerospace nvim ghostty  # Create symlinks
ls -la ~ | grep -E "gitconfig|zshrc"                # Verify (look for 'l' and '->')
```

## Structure

**GNU Stow pattern** - Each directory is a "package" mirroring home directory:
```
zsh/.zshrc                  → ~/.zshrc
nvim/.config/nvim/init.lua  → ~/.config/nvim/init.lua
aerospace/.aerospace.toml   → ~/.aerospace.toml (NOT .config/)
```

**Key files:**
```
~/.dotfiles/
├── git/.gitconfig          # Git base config
├── zsh/.zshrc, .p10k.zsh   # Shell + theme (127 + 89KB)
├── tmux/.tmux.conf         # Custom tmux (115 lines + TPM plugins)
├── aerospace/.aerospace.toml  # Window manager
├── nvim/.config/nvim/      # Editor (LazyVim + plugins)
│   ├── lua/config/vscode.lua  # VSCode-specific Neovim config
│   └── init.lua            # Conditional loading (terminal vs VSCode)
├── vscode/                 # VSCode settings (OS-specific symlinks)
│   ├── settings.json
│   └── keybindings.json
├── ghostty/.config/ghostty/config  # Terminal
├── Brewfile                # Package manifest
└── install.sh              # Automated setup (includes VSCode symlinks)
```

## Keybinds

**Vi motions everywhere:**
- **AeroSpace**: `Alt+HJKL` (focus), `Alt+Shift+HJKL` (move)
- **tmux**: `Ctrl+HJKL` (navigate panes/nvim via vim-tmux-navigator)
- **Neovim**: Native `HJKL`, `Space` leader (LazyVim)
- **VSCode**: All vim motions + `Ctrl+HJKL` (navigate editor/explorer/terminal)

**See detailed shortcuts:**
- [Neovim keybindings](docs/nvim-shortcuts.md) - LazyVim shortcuts (terminal)
- [VSCode keybindings](docs/vscode-shortcuts.md) - vscode-neovim shortcuts
- [tmux keybindings](docs/tmux-shortcuts.md) - Essential → Advanced

## Highlights

**zsh aliases:**
- `inv` - Nvim with fzf picker + bat preview
- `vi` → `nvim`
- `z <dir>` - Smart jump (zoxide)
- `zi` - Interactive jump (zoxide + fzf)

**AeroSpace app launchers** (`Shift-Ctrl-Alt-Cmd` + key):
- `A` Ghostty, `B` Arc, `C` Claude, `D` Discord, `M` Music, `N` Obsidian, `O` Outlook, `P` Bitwarden, `T` Teams

**tmux splits** (`prefix = Ctrl+b` or `Ctrl+a`):
- `prefix -` - Horizontal (top/bottom)
- `prefix |` - Vertical (left/right)
- `prefix r` - Reload config

**Neovim** (terminal):
- `<leader>sf` - Find files (Telescope)
- `<leader>sg` - Live grep
- `grd` - Go to definition
- `K` - Hover docs

**VSCode** (vscode-neovim):
- `<leader>ff` - Find files (Quick Open)
- `<leader>/` - Search in files
- `Ctrl+/` - Toggle terminal, `Ctrl+d` - Close terminal
- `t` (in Explorer) - Open terminal at location
- `<leader>ca` - Code actions
- All vim motions work (`ciw`, `dd`, `gg`, etc.)

## Usage

**Machine-specific overrides** (gitignored):
```bash
~/.gitconfig.local           # Git email, name
~/.zshrc.local              # Shell customizations
~/.tmux.conf.local          # tmux local overrides (optional)
```

**Add new package:**
```bash
mkdir -p newapp/.config/newapp
cp ~/.config/newapp/config newapp/.config/newapp/
stow --target="$HOME" newapp
ls -la ~/.config/newapp  # Verify (look for 'l' and '->')
```

**Update Brewfile after installing packages:**
```bash
brew bundle dump --describe --force
```

**Update plugins:**
```bash
:Lazy update     # Neovim (in editor)
omz update       # Oh My Zsh
```

## Dependencies

**Homebrew** (see Brewfile):
neovim, tmux, fzf, zoxide, atuin, carapace, the_silver_searcher, bat, stow, aerospace, powerlevel10k

**Manual**:
- [Oh My Zsh](https://ohmyz.sh/)
- [TPM](https://github.com/tmux-plugins/tpm) (Tmux Plugin Manager)

## Troubleshooting

| Issue | Solution |
|-------|----------|
| **Stow conflicts** | `mv ~/.zshrc ~/.zshrc.backup` then restow |
| **AeroSpace not loading** | `Alt+Shift+;` then `Escape` or `brew services restart aerospace` |
| **Neovim plugins broken** | `:checkhealth` then `:Lazy restore` |
| **tmux not applying** | `tmux source-file ~/.tmux.conf` or `tmux kill-server` |
| **Verify symlinks** | `ls -la ~ \| grep zshrc` (should show `l` and `->`) |

## Roadmap

**Recently added:** zoxide, atuin, carapace
**Planned:** Starship prompt, Zsh vi-mode, additional LSPs (Python, JSON, YAML, Shell, K8s)
**Out of scope:** macOS system preferences, secrets management, SSH keys, non-Neovim IDEs

## Credits

Built on: [Kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) · [Oh My Zsh](https://ohmyz.sh/) · [Powerlevel10k](https://github.com/romkatv/powerlevel10k) · [AeroSpace](https://github.com/nikitabobko/AeroSpace) · [TPM](https://github.com/tmux-plugins/tpm)

## License

MIT
