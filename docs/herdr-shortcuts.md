# herdr Shortcuts

**Config**: `~/.dotfiles/herdr/.config/herdr/config.toml` (stowed) · Tokyo Night theme
**Prefix**: `Ctrl+a` (single prefix only — herdr has no secondary prefix)
**Model**: workspace ("space") → tab → pane, matching tmux's session → window → pane

Bindings mirror [tmux](tmux-shortcuts.md) wherever herdr allows it. Differences
from tmux are called out in [Where herdr differs](#where-herdr-differs).

> **Literal `Ctrl+a` is unavailable inside herdr panes.** herdr has no
> `send-prefix` equivalent, so beginning-of-line in zsh and increment-number in
> Neovim are not reachable. Use `Home`, or bind an alternative in `~/.zshrc`.

---

## Essential (Daily Use)

### Splits
| Shortcut | Description |
|----------|-------------|
| `prefix \|` | Split vertically (left/right) — also `prefix v` |
| `prefix -` | Split horizontally (top/bottom) |
| `prefix x` | Close pane |

### Pane Navigation
| Shortcut | Description |
|----------|-------------|
| `prefix h/j/k/l` | Focus pane left/down/up/right |
| `prefix Tab` | Toggle back to last pane |
| `prefix +` | Toggle pane zoom — also `prefix z` |

### Spaces & Tabs
| Shortcut | Description |
|----------|-------------|
| `prefix c` | New tab |
| `prefix Ctrl+c` | New space |
| `prefix o` | Space picker — also `prefix w` |
| `prefix d` | Detach (server and agents keep running) — also `prefix q` |

### Config
| Shortcut | Description |
|----------|-------------|
| `prefix r` | Reload config — also `prefix Shift+r` |
| `prefix ?` | List all keybindings |

---

## Common (Frequently Used)

### Tab Management (tmux windows)
| Shortcut | Description |
|----------|-------------|
| `prefix 1-9` | Switch to tab 1-9 |
| `prefix n` | Next tab — also `prefix Ctrl+l` |
| `prefix p` | Previous tab — also `prefix Ctrl+h` |
| `prefix ,` | Rename tab — also `prefix Shift+t` |
| `prefix Shift+x` | Close tab |

### Space Management (tmux sessions)
| Shortcut | Description |
|----------|-------------|
| `prefix Shift+1-9` | Switch to space 1-9 |
| `prefix Shift+j` | Next space |
| `prefix Shift+k` | Previous space |
| `prefix Shift+w` | Rename current space |
| `prefix Shift+d` | Close space (asks for confirmation) |
| `prefix Ctrl+f` | Goto / find — also `prefix g` |

### Navigate Mode (`prefix g`)
Local keys that win while navigate mode is open.

| Shortcut | Description |
|----------|-------------|
| `j` / `k` | Move down/up the space list |
| `h` / `l` | Move to pane left/right |
| `↓` / `↑` | Move to pane down/up |
| `←` / `→` | Move to pane left/right (always, regardless of config) |

---

## Advanced (Power User)

### Panes & UI
| Shortcut | Description |
|----------|-------------|
| `prefix Ctrl+r` | Resize mode (herdr's replacement for tmux `HJKL`) |
| `prefix Shift+p` | Rename pane |
| `prefix e` | Edit scrollback in `$EDITOR` |
| `prefix b` | Toggle sidebar |
| `prefix s` | Settings |
| `prefix Shift+Tab` | Cycle to previous pane |

### CLI (socket API)
herdr exposes the same operations over a socket, useful for scripting.

| Command | Description |
|---------|-------------|
| `herdr` | Launch or attach to the persistent session |
| `herdr config check` | Validate `config.toml` and print diagnostics |
| `herdr server reload-config` | Reload config into the running server |
| `herdr workspace list` | List spaces with IDs and labels |
| `herdr workspace rename <id> <label>` | Rename a space by ID |
| `herdr workspace create\|focus\|close` | Space lifecycle |
| `herdr tab \| pane \| agent <sub>` | Tab, pane, and agent helpers |
| `herdr status` | Show client and server status |
| `herdr config reset-keys` | Back up config and drop custom keybindings |

Spaces are auto-labeled from their directory, so several can share a name.
`herdr workspace list` is the reliable way to get IDs.

---

## Where herdr differs

Kept deliberately different from tmux, because herdr has no equivalent:

| tmux | herdr | Why |
|------|-------|-----|
| `prefix r` reload | same | herdr's default `r` (resize mode) moved to `Ctrl+r` |
| `prefix H/J/K/L` resize | `prefix Ctrl+r` then keys | herdr resizes through a mode, not repeatable keys |
| `prefix Tab` last **window** | last **pane** | herdr has `last_pane` but no `last_tab` |
| `prefix [` copy mode, `v`/`y` | mouse selection | herdr is mouse-first; no vi copy mode |
| `Ctrl+h/j/k/l` seamless nvim nav | *not available* | no `vim-tmux-navigator` equivalent |
| `prefix BTab` last session | *not available* | no `last_workspace` action |
| `prefix </>`  swap panes | *not available* | no pane-swap action |
| `Ctrl+b` **and** `Ctrl+a` | `Ctrl+a` only | herdr supports a single prefix |

Two open gaps with no workaround yet: **vi copy mode** and **seamless
`Ctrl+h/j/k/l` navigation between Neovim splits and herdr panes**. herdr has a
plugin/marketplace system that may be able to cover the latter.

---

## Configuration

**File**: `~/.dotfiles/herdr/.config/herdr/config.toml` → `~/.config/herdr/config.toml`
**Theme**: `tokyo-night` (matches tmux, Neovim, and VSCode)
**Validate**: `herdr config check` — run after every edit
**Reload**: `prefix r`, or `herdr server reload-config`

**Key config highlights**:
- `prefix = "ctrl+a"` — revert to `ctrl+b` via the commented line in `[keys]`
- `resume_agents_on_restore = true` — agents resume after a server restart
- `confirm_close = true` — confirm before closing a space
- Navigate-mode keys are written out explicitly; `herdr config check` only
  compares bindings you set, not against unstated defaults, so relying on
  defaults there can hide a silent collision

**Runtime files** in `~/.config/herdr/` (`session.json`, `*.sock`, `*.log`) are
generated and stay outside the repo. Stow links only `config.toml`.
