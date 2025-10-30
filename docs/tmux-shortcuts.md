# tmux Shortcuts

Complete reference for tmux keybindings organized by importance.

**Prefix Key**: `Ctrl+b` (default tmux prefix)

---

## Essential (Daily Use)

### Window/Pane Navigation
| Shortcut | Description |
|----------|-------------|
| `Ctrl+h` | Move to left pane (vim-tmux-navigator) |
| `Ctrl+j` | Move to lower pane (vim-tmux-navigator) |
| `Ctrl+k` | Move to upper pane (vim-tmux-navigator) |
| `Ctrl+l` | Move to right pane (vim-tmux-navigator) |

**Note**: These work seamlessly between Neovim and tmux panes (via vim-tmux-navigator plugin).

### Window/Pane Creation
| Shortcut | Description |
|----------|-------------|
| `prefix \|` | Split pane horizontally (custom) |
| `prefix -` | Split pane vertically (custom) |
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
| `prefix !` | Convert pane to window |
| `prefix o` | Cycle through panes |
| `prefix q` | Show pane numbers |
| `prefix {` | Swap pane with previous |
| `prefix }` | Swap pane with next |

### Pane Resizing (gpakosz)
| Shortcut | Description |
|----------|-------------|
| `prefix H` | Resize pane left |
| `prefix J` | Resize pane down |
| `prefix K` | Resize pane up |
| `prefix L` | Resize pane right |
| `prefix <` | Move pane position left |
| `prefix >` | Move pane position right |

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
| `prefix $` | Rename current session |
| `tmux new -s <name>` | Create named session (command line) |
| `tmux ls` | List sessions (command line) |
| `tmux kill-session -t <name>` | Kill named session (command line) |

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
| `prefix :` | Enter command mode |
| `prefix r` | Reload tmux config (gpakosz) |
| `prefix ?` | List all keybindings |
| `prefix t` | Show clock |
| `tmux source-file ~/.tmux.conf` | Reload config (command line) |

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

## gpakosz Oh-my-tmux Specific

The configuration uses the [gpakosz Oh-my-tmux framework](https://github.com/gpakosz/.tmux), which provides additional features:

### Additional Features
- **Mouse support**: Enabled by default
- **Status bar**: Custom theme with dark gray (#080808), light blue (#00afff), yellow (#ffff00)
- **Vi-mode**: Enabled in copy mode
- **Automatic rename**: Windows auto-rename based on running command
- **Activity monitoring**: Visual notifications for activity in other windows

### Framework-Specific Shortcuts
| Shortcut | Description |
|----------|-------------|
| `prefix C-c` | Create new session |
| `prefix C-f` | Find session |
| `prefix +` | Maximize current pane |
| `prefix m` | Toggle mouse mode |
| `prefix Enter` | Enter copy mode |

---

## Configuration Files

- **Base config**: `tmux.conf` (422 bytes) - Basic settings, plugin declarations
- **Customizations**: `.tmux.conf.local` (19KB) - gpakosz overrides, theme colors
- **Framework**: `~/.tmux-gpakosz/.tmux.conf` (external dependency)

---

## Plugin: vim-tmux-navigator

Seamless navigation between vim/nvim and tmux panes using `Ctrl+h/j/k/l`. Works automatically when plugin is installed via TPM.

**Installation**: Automatically installed via TPM on first run (`prefix + I`)
