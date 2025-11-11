# VSCode Shortcuts (with vscode-neovim)

**Config**: vscode-neovim extension · LazyVim keybinding semantics
**Leader**: `Space`
**Philosophy**: Match LazyVim muscle memory where applicable, leverage VSCode where unique

**Seamless navigation**: `Ctrl+h/j/k/l` works across editor/explorer/terminal/splits

---

## Core Concepts

**What works automatically (1:1 with terminal Neovim)**:
- All vim motions: `hjkl`, `w`, `b`, `e`, `ciw`, `dd`, `yy`, `p`, etc.
- `jj` or `jk` - Exit insert mode
- `Esc` - Clear search highlighting
- Visual mode: `v`, `V`, `Ctrl+v`
- Indenting: `>`, `<` (keeps selection in visual mode)
- Move lines: `J`, `K` in visual mode
- `gg`, `G`, `Ctrl+d`, `Ctrl+u` - Navigation with centering
- Clipboard: `y` yanks to system clipboard automatically

**What's mapped to VSCode actions**:
- File/project navigation
- Terminal management
- Code actions and LSP
- Debugging
- Git/source control

---

## Essential (Daily Use)

### Navigation & File Management
| Shortcut | Description |
|----------|-------------|
| `<leader>e` | Toggle sidebar (Explorer/Source Control) |
| `<leader>E` | Open Extensions view |
| `<leader>ff` | Find files (Quick Open) |
| `<leader>fr` | Recent files |
| `<leader>fn` | New file |
| `Ctrl+h/j/k/l` | Navigate left/down/up/right (works from any panel) |

**Navigation notes**:
- `Ctrl+hjkl` works from editor, explorer, terminal, any split
- `<leader>e` toggles sidebar (doesn't force Explorer if you're in Source Control)
- Use `Ctrl+h` to get back to editor from sidebar

### Search & Command Palette
| Shortcut | Description |
|----------|-------------|
| `<leader>/` | Search in files (Find in Files) |
| `<leader><space>` | Command Palette |

### Terminal
| Shortcut | Description |
|----------|-------------|
| `Ctrl+/` | Toggle terminal (opens with focus, closes and returns) |
| `<leader>tn` | New terminal |
| `Shift+Enter` | Line continuation (`\` + newline) when in terminal |

**Terminal notes**:
- `Ctrl+/` in editor: Opens terminal with focus
- `Ctrl+/` in terminal: Closes terminal, returns to editor
- May beep on macOS (Chromium/Electron limitation, not fixable)

### Buffer/Tab Management
| Shortcut | Description |
|----------|-------------|
| `Shift+h` | Previous tab/editor |
| `Shift+l` | Next tab/editor |
| `<leader>bd` | Close current buffer/tab |

---

## Common (Frequently Used)

### Code Actions & LSP
| Shortcut | Description |
|----------|-------------|
| `<leader>ca` | Code Actions (Quick Fix) |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format document |
| `K` | Show hover documentation |
| `gd` | Go to definition (vscode-neovim handles automatically) |
| `gr` | Go to references (vscode-neovim handles automatically) |

**LSP notes**:
- `gd`, `gr`, and other LSP motions work automatically via vscode-neovim
- No special configuration needed for most LSP features

### Window/Split Management
| Shortcut | Description |
|----------|-------------|
| `<leader>ws` | Split editor down (horizontal) |
| `<leader>wv` | Split editor right (vertical) |
| `<leader>wc` | Close current split |
| `<leader>wo` | Close other editors |
| `Ctrl+h/j/k/l` | Navigate between splits |

### Git/Source Control
| Shortcut | Description |
|----------|-------------|
| `<leader>gg` | Open Source Control view |

### AI Assistants
| Shortcut | Description |
|----------|-------------|
| `<leader>aa` | Open Copilot Chat |
| `<leader>ai` | Inline Chat (quick fix/edit) |
| `<leader>aq` | Quick chat toggle |
| `<leader>ac` | Open Claude terminal |
| `<leader>ao` | Open ChatGPT sidebar |

---

## Advanced

### Debugging
| Shortcut | Description |
|----------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Debug continue |

### Quality of Life
| Shortcut | Description |
|----------|-------------|
| `<Esc>` | Clear search highlighting |
| `Ctrl+d` | Scroll down and center |
| `Ctrl+u` | Scroll up and center |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |

### Visual Mode Enhancements
| Shortcut | Description |
|----------|-------------|
| `<` | Unindent (keeps selection) |
| `>` | Indent (keeps selection) |
| `J` | Move selection down |
| `K` | Move selection up |
| `p` | Paste over selection (doesn't yank replaced text) |

---

## Comparison with LazyVim

**Identical semantics**:
- `<leader>e` - File explorer (neo-tree → VSCode sidebar)
- `<leader>ff` - Find files (Telescope → Quick Open)
- `<leader>/` - Search in files (Telescope grep → Find in Files)
- `<leader>ca` - Code actions
- `<leader>cr` - Rename symbol
- `<leader>cf` - Format document
- `<leader>bd` - Close buffer
- `Shift+h/l` - Navigate buffers/tabs
- `K` - Hover documentation

**VSCode-specific additions**:
- `<leader>E` - Extensions view
- `<leader><space>` - Command Palette
- `<leader>db/dc` - Debugging
- `<leader>tn` - New terminal
- `Ctrl+/` - Terminal toggle (LazyVim uses `Ctrl+/` too)

**What's different**:
- `<leader>e` toggles sidebar (doesn't force switch between Explorer/Source Control)
- Terminal management is VSCode-specific (LazyVim uses different approach)
- Debugging shortcuts only exist in VSCode

---

## Settings Notes

**Clipboard integration**:
- `vim.opt.clipboard = "unnamedplus"` is set
- Normal `y` yanks to system clipboard
- Normal `p` pastes from system clipboard
- Works with `Cmd+V` outside VSCode

**Font & Appearance** (in settings.json):
- FiraCode Nerd Font with ligatures enabled
- Same font as terminal Neovim setup

**Keybinding contexts**:
- Leader-based bindings only work in editor (via Neovim)
- `Ctrl+hjkl` works everywhere via keybindings.json with `"when": "!editorTextFocus"`
- Space key works normally in explorer/terminal (no conflicts)

---

## Quick Reference

**File/Project**:
- `<leader>ff` - Find file
- `<leader>fr` - Recent files
- `<leader>fn` - New file
- `<leader>e` - Toggle sidebar
- `Ctrl+h/l` - Switch between sidebar/editor

**Search**:
- `/` - Search in current file
- `<leader>/` - Search in all files
- `<leader><space>` - Command Palette

**Code**:
- `K` - Hover docs
- `gd` - Go to definition
- `<leader>ca` - Code actions
- `<leader>cr` - Rename
- `<leader>cf` - Format document

**Terminal**:
- `Ctrl+/` - Toggle terminal
- `<leader>tn` - New terminal

**Tabs**:
- `Shift+h/l` - Previous/next tab
- `<leader>bd` - Close tab

**AI**:
- `<leader>aa` - Copilot Chat
- `<leader>ai` - Inline chat
- `<leader>ac` - Claude terminal
- `<leader>ao` - ChatGPT sidebar

**Learning**:
- `<leader>sk` - Search keymaps (to see all available bindings)
- `<leader>sh` - Search help

---

## Configuration Files

**VSCode settings**: `~/.dotfiles/vscode/settings.json`
**VSCode keybindings**: `~/.dotfiles/vscode/keybindings.json`
**Neovim VSCode config**: `~/.dotfiles/nvim/.config/nvim/lua/config/vscode.lua`

To edit:
```bash
cd ~/.dotfiles
nvim vscode/settings.json      # VSCode settings
nvim nvim/.config/nvim/lua/config/vscode.lua  # VSCode-specific Neovim bindings
```

Changes to settings.json and keybindings.json require VSCode reload.
Changes to vscode.lua take effect on next file open in VSCode.
