# tmux Shortcuts

**Config**: Minimal custom (115 lines) · Tokyo Night theme · TPM plugins
**Prefix**: `Ctrl+b` (default) or `Ctrl+a` (secondary)
**Plugins**: vim-tmux-navigator, tmux-yank, tmux-resurrect, tmux-continuum, tmux-fzf-url, tmux-sessionx

**Seamless navigation**: `Ctrl+h/j/k/l` works across tmux ↔ Neovim panes (vim-tmux-navigator)

---

## Essential (Daily Use)

### Seamless Navigation (No Prefix!)
| Shortcut | Description |
|----------|-------------|
| `Ctrl+h/j/k/l` | Move left/down/up/right between panes AND Neovim windows |

### Window/Pane Creation
| Shortcut | Description |
|----------|-------------|
| `prefix -` | Split horizontally (top/bottom) |
| `prefix |` | Split vertically (left/right) |
| `prefix c` | Create new window |

### Session Management
| Shortcut | Description |
|----------|-------------|
| `prefix d` | Detach from session |
| `prefix (` | Switch to previous session |
| `prefix )` | Switch to next session |
| `tmux attach` | Attach to last session (command line) |
| `tmux attach -t <name>` | Attach to named session (command line) |

---

## Common (Frequently Used)

### Window Management
| Shortcut | Description |
|----------|-------------|
| `prefix 0-9` | Switch to window 0-9 |
| `prefix n` | Next window |
| `prefix p` | Previous window |
| `prefix w` | List windows (interactive) |
| `prefix ,` | Rename current window |
| `prefix &` | Kill current window |
| `prefix .` | Move window to different position |

### Pane Management
| Shortcut | Description |
|----------|-------------|
| `prefix x` | Kill current pane |
| `prefix z` | Toggle pane zoom (fullscreen) |
| `prefix +` | Toggle pane zoom (custom alias) |
| `prefix !` | Convert pane to window |
| `prefix q` | Show pane numbers |
| `prefix {` | Swap pane with previous |
| `prefix }` | Swap pane with next |

### Pane Resizing
| Shortcut | Description |
|----------|-------------|
| `prefix H/J/K/L` | Resize pane left/down/up/right (repeatable) |
| `prefix </>`  | Swap pane position left/right |

### Copy Mode (Vi-style)
| Shortcut | Description |
|----------|-------------|
| `prefix [` | Enter copy mode |
| `Space` | Start selection (in copy mode) |
| `Enter` | Copy selection (in copy mode) |
| `prefix ]` | Paste buffer |
| `h/j/k/l` | Navigate (in copy mode) |
| `v` | Begin selection (in copy mode, vi-mode) |
| `y` | Yank/copy selection (in copy mode, vi-mode) |
| `q` | Exit copy mode |

---

## Advanced (Power User)

### Session Management
| Shortcut | Description |
|----------|-------------|
| `prefix s` | List sessions (interactive) |
| `prefix o` | Session picker with fzf (tmux-sessionx + zoxide) |
| `prefix C-c` | Create new session |
| `prefix C-f` | Find session |
| `prefix $` | Rename current session |
| `prefix BTab` | Switch to last session |

### Window/Pane Layouts
| Shortcut | Description |
|----------|-------------|
| `prefix Space` | Cycle through layouts |
| `prefix Alt+1` | Even horizontal layout |
| `prefix Alt+2` | Even vertical layout |
| `prefix Alt+3` | Main horizontal layout |
| `prefix Alt+4` | Main vertical layout |
| `prefix Alt+5` | Tiled layout |

### Configuration & System
| Shortcut | Description |
|----------|-------------|
| `prefix r` | Reload config (shows checkmark on status bar) |
| `prefix e` | Edit config in nvim |
| `prefix :` | Enter command mode |
| `prefix ?` | List all keybindings |
| `prefix t` | Show clock |

### Advanced Copy Mode
| Shortcut | Description |
|----------|-------------|
| `/` | Search forward (in copy mode) |
| `?` | Search backward (in copy mode) |
| `n` | Next search result (in copy mode) |
| `N` | Previous search result (in copy mode) |
| `Ctrl+u` | Scroll up half page (in copy mode) |
| `Ctrl+d` | Scroll down half page (in copy mode) |
| `g` | Go to top (in copy mode) |
| `G` | Go to bottom (in copy mode) |

### Buffer Management
| Shortcut | Description |
|----------|-------------|
| `prefix #` | List all paste buffers |
| `prefix =` | Choose which buffer to paste |
| `prefix -` | Delete most recent buffer |

---

## TPM Plugins

**vim-tmux-navigator** - Seamless `Ctrl+h/j/k/l` navigation between tmux/nvim
**tmux-yank** - Better clipboard integration
**tmux-resurrect** - Save/restore tmux sessions (auto-saves nvim sessions)
**tmux-continuum** - Auto-restore on tmux start
**tmux-fzf-url** - Fuzzy find URLs in terminal output
**tmux-sessionx** - Enhanced session picker with fzf + zoxide (`prefix o`)
**tmux-tokyo-night** - Tokyo Night theme with transparency

### Plugin Management
| Command | Description |
|---------|-------------|
| `prefix I` | Install plugins (first time) |
| `prefix U` | Update plugins |
| `prefix alt+u` | Uninstall plugins |

---

## Configuration

**File**: `~/.dotfiles/tmux/.tmux.conf` (115 lines)
**Features**: Dual prefix (Ctrl+b/Ctrl+a), vi-mode, mouse support, status bar on top, Tokyo Night theme
**Plugins**: Managed by TPM at `~/.tmux/plugins/tpm`

**Key config highlights**:
- `base-index 1` - Windows start at 1
- `escape-time 10` - Fast for vim
- `history-limit 50000` - 50K lines scrollback
- `set-clipboard on` - System clipboard integration
- `detach-on-destroy off` - Don't exit tmux when closing last session
