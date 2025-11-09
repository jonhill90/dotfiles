# Neovim Shortcuts

**Config**: Kickstart.nvim · Tokyo Night theme · Terraform & Lua LSPs (Mason)
**Leader**: `Space`
**Plugins**: lazy.nvim, Telescope, Treesitter, blink.cmp, neo-tree, gitsigns, conform.nvim, GitHub Copilot

**Seamless navigation**: `Ctrl+h/j/k/l` works across Neovim ↔ tmux panes (vim-tmux-navigator)

---

## Essential (Daily Use)

### Basic Navigation
| Shortcut | Description |
|----------|-------------|
| `h/j/k/l` | Left/Down/Up/Right (vi-motion) |
| `Ctrl+h/j/k/l` | Move to left/down/up/right window (works with tmux!) |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |
| `gg` | Go to top of file |
| `G` | Go to bottom of file |

### File Operations
| Shortcut | Description |
|----------|-------------|
| `<leader>sf` | [S]earch [F]iles (Telescope) |
| `<leader><leader>` | Find existing buffers (Telescope) |
| `<leader>nf` | [N]ew [F]ile |
| `<leader>qf` | [Q]uit [F]ile/Buffer |
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |

### Search & Find
| Shortcut | Description |
|----------|-------------|
| `<leader>sg` | [S]earch by [G]rep (live grep) |
| `<leader>sw` | [S]earch current [W]ord |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Search in open files |
| `/` | Search forward |
| `?` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `Esc` | Clear search highlights |

### Editing Basics
| Shortcut | Description |
|----------|-------------|
| `i` | Insert mode |
| `a` | Append (insert after cursor) |
| `o` | Open line below |
| `O` | Open line above |
| `Esc` | Return to normal mode |
| `u` | Undo |
| `Ctrl+r` | Redo |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

---

## Common (Frequently Used)

### LSP (Language Server Protocol)
| Shortcut | Description |
|----------|-------------|
| `grd` | [G]oto [D]efinition |
| `grr` | [G]oto [R]eferences |
| `gri` | [G]oto [I]mplementation |
| `grt` | [G]oto [T]ype Definition |
| `grn` | [R]e[n]ame |
| `gra` | [G]oto Code [A]ction |
| `grD` | [G]oto [D]eclaration |
| `gO` | Open Document Symbols |
| `gW` | Open Workspace Symbols |
| `K` | Hover documentation |
| `Ctrl+t` | Jump back (after goto definition) |

### Diagnostics
| Shortcut | Description |
|----------|-------------|
| `<leader>dl` | [D]iagnostics [L]ist (Quickfix) |
| `<leader>df` | [D]iagnostics [F]loat |
| `<leader>sd` | [S]earch [D]iagnostics (Telescope) |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Telescope (Fuzzy Finder)
| Shortcut | Description |
|----------|-------------|
| `<leader>sh` | [S]earch [H]elp |
| `<leader>sk` | [S]earch [K]eymaps |
| `<leader>sf` | [S]earch [F]iles |
| `<leader>ss` | [S]earch [S]elect Telescope |
| `<leader>sg` | [S]earch by [G]rep |
| `<leader>sr` | [S]earch [R]esume |
| `<leader>s.` | Search Recent Files |
| `<leader>sn` | [S]earch [N]eovim config files |

**In Telescope picker**:
- `Ctrl+/` (insert mode) or `?` (normal mode): Show help
- `Ctrl+n/p` or `↑/↓`: Navigate results
- `Enter`: Select
- `Esc`: Close

### File Explorer (neo-tree)
| Shortcut | Description |
|----------|-------------|
| `\\` | Toggle neo-tree file explorer |
| `<leader>e` | Focus neo-tree (if open) |

**In neo-tree**:
- `a`: Add file/folder
- `d`: Delete
- `r`: Rename
- `c`: Copy
- `x`: Cut
- `p`: Paste
- `R`: Refresh
- `?`: Show help

### Tabs & Windows
| Shortcut | Description |
|----------|-------------|
| `<leader>nt` | [N]ew [T]ab |
| `<leader>qt` | [Q]uit [T]ab |
| `<leader>qa` | [Q]uit [A]ll other tabs |
| `gt` | Next tab |
| `gT` | Previous tab |

### Formatting
| Shortcut | Description |
|----------|-------------|
| `<leader>f` | [F]ormat buffer (conform.nvim) |
| `=` | Format selection (visual mode) |
| `gg=G` | Format entire file |

---

## Advanced (Power User)

### Text Objects (mini.ai)
| Shortcut | Description |
|----------|-------------|
| `va)` | [V]isually select [A]round [)]paren |
| `vi"` | [V]isually select [I]nside ["]quote |
| `ci'` | [C]hange [I]nside [']quote |
| `da{` | [D]elete [A]round [{]brace |
| `yinq` | [Y]ank [I]nside [N]ext [Q]uote |

### Surround (mini.surround)
| Shortcut | Description |
|----------|-------------|
| `saiw)` | [S]urround [A]dd [I]nner [W]ord [)]Paren |
| `sd'` | [S]urround [D]elete [']quotes |
| `sr)'` | [S]urround [R]eplace [)] ['] |

### Terminal
| Shortcut | Description |
|----------|-------------|
| `Ctrl+\` | Toggle floating terminal |
| `Ctrl+e` | Exit terminal mode |
| `<leader>nn` | [N]ew floating [N]terminal |
| `<leader>nN` | [N]ew horizontal [N]terminal |
| `<leader>nV` | [N]ew [V]ertical terminal |
| `<leader>st` | [S]earch [T]erminal viewer |
| `<leader>tt` | [T]oggle current [T]erminal |

**In Terminal picker**:
- `Enter`: Open selected terminal
- `Ctrl+x`: Close selected terminal

### Completion (blink.cmp)
| Shortcut | Description |
|----------|-------------|
| `Ctrl+y` | Accept completion |
| `Tab` | Next snippet field |
| `Shift+Tab` | Previous snippet field |
| `Ctrl+Space` | Open menu or docs |
| `Ctrl+n/p` | Select next/previous item |
| `Ctrl+e` | Hide menu |
| `Ctrl+k` | Toggle signature help |

### GitHub Copilot
| Shortcut | Description |
|----------|-------------|
| `Ctrl+g` | Accept Copilot suggestion (insert mode) |
| `Alt+]` | Next Copilot suggestion (insert mode) |
| `Alt+[` | Previous Copilot suggestion (insert mode) |
| `Ctrl+]` | Dismiss Copilot (insert mode) |

### Git (gitsigns)
| Shortcut | Description |
|----------|-------------|
| `<leader>h` | Git [H]unk group (normal/visual mode) |
| `]c` | Next hunk |
| `[c` | Previous hunk |

### Markdown
| Shortcut | Description |
|----------|-------------|
| `<leader>tm` | [T]oggle inline [M]arkdown rendering |

### Toggles
| Shortcut | Description |
|----------|-------------|
| `<leader>th` | [T]oggle Inlay [H]ints (LSP) |
| `<leader>tm` | [T]oggle inline [M]arkdown |

### Advanced Navigation
| Shortcut | Description |
|----------|-------------|
| `{` | Previous paragraph/block |
| `}` | Next paragraph/block |
| `%` | Jump to matching bracket/paren |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |
| `w` | Next word |
| `b` | Previous word |
| `e` | End of word |
| `0` | Start of line |
| `$` | End of line |
| `^` | First non-blank character |

### Marks
| Shortcut | Description |
|----------|-------------|
| `m{a-z}` | Set local mark |
| `m{A-Z}` | Set global mark |
| `'{mark}` | Jump to mark line |
| `` `{mark}`` | Jump to mark position |
| `''` | Jump to previous position |

### Registers
| Shortcut | Description |
|----------|-------------|
| `"{register}y` | Yank to register |
| `"{register}p` | Paste from register |
| `:reg` | Show all registers |
| `"0p` | Paste from yank register (not delete) |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |

### Macros
| Shortcut | Description |
|----------|-------------|
| `q{register}` | Start recording macro |
| `q` | Stop recording |
| `@{register}` | Play macro |
| `@@` | Replay last macro |

### Visual Mode
| Shortcut | Description |
|----------|-------------|
| `v` | Character-wise visual |
| `V` | Line-wise visual |
| `Ctrl+v` | Block-wise visual |
| `gv` | Reselect last visual selection |
| `>` | Indent selection |
| `<` | Unindent selection |

### Commands
| Shortcut | Description |
|----------|-------------|
| `:Lazy` | Open plugin manager |
| `:Mason` | Open LSP installer |
| `:checkhealth` | Check Neovim health |
| `:Telescope` | Open Telescope |
| `:ConformInfo` | Show formatter info |

---

## Plugin-Specific Features

### Lazy.nvim (Plugin Manager)
- **UI**: `:Lazy`
- **Update**: `:Lazy update`
- **Sync**: `:Lazy sync`
- **Clean**: `:Lazy clean`

### Mason (LSP Installer)
- **UI**: `:Mason`
- Press `?` in Mason UI for help
- Press `g?` for help

### Treesitter (Syntax Highlighting)
- **Update**: `:TSUpdate`
- **Install**: `:TSInstall <language>`
- **Info**: `:TSInstallInfo`

---

## Quick Reference

**Learning**:
- `:Tutor` - Interactive tutorial
- `<leader>sh` - Search help (Telescope)
- `<leader>sk` - Search keymaps (Telescope)
- `:help lsp` / `:help lua-guide` / `:help telescope.builtin`

**Customization**:
- Add plugins: `lua/custom/plugins/*.lua` or directly in `init.lua`
