# Vim Motions Reference

Essential vim motions for VSCode users. Learn the composable power of vim keybindings.

**Philosophy**: Vim motions compose like a language: `[operator][count][motion/text-object]`

---

## VSCode vs Vim Equivalents

Quick reference for common VSCode shortcuts translated to vim:

| VSCode | Vim | Description |
|--------|-----|-------------|
| `Ctrl+A` | `ggVG` | Select all |
| `Ctrl+A, Ctrl+C` | `ggVGy` | Select all and copy |
| `Ctrl+D` (select word) | `*` or `#` | Find next/previous word |
| `Ctrl+L` (select line) | `V` | Select line |
| `Ctrl+Shift+K` | `dd` | Delete line |
| `Ctrl+C` (copy line) | `yy` | Yank/copy line |
| `Ctrl+X` (cut line) | `dd` | Delete/cut line |
| `Home` | `0` or `^` | Start of line |
| `End` | `$` | End of line |
| `Ctrl+Home` | `gg` | Top of file |
| `Ctrl+End` | `G` | Bottom of file |
| `Ctrl+Right` | `w` | Next word |
| `Ctrl+Left` | `b` | Previous word |
| `Ctrl+Backspace` | `db` | Delete word backward |
| `Ctrl+Delete` | `dw` | Delete word forward |

---

## The Vim Grammar

Vim commands follow a composable pattern:

```
[operator][count][motion/text-object]
```

**Examples:**
- `d2w` = Delete 2 words
- `c3j` = Change 3 lines down
- `y$` = Yank to end of line
- `diw` = Delete inner word
- `ci"` = Change inside quotes

---

## Core Motions

### Character/Line Movement
| Motion | Description |
|--------|-------------|
| `h` | Left |
| `j` | Down |
| `k` | Up |
| `l` | Right |
| `0` | Start of line (column 0) |
| `^` | First non-whitespace character |
| `$` | End of line |
| `g_` | Last non-whitespace character |

### Word Movement
| Motion | Description |
|--------|-------------|
| `w` | Next word start |
| `W` | Next WORD start (space-delimited) |
| `e` | Next word end |
| `E` | Next WORD end |
| `b` | Previous word start |
| `B` | Previous WORD start |
| `ge` | Previous word end |

**Note**: `word` = alphanumeric + underscore, `WORD` = anything non-whitespace

### Line Navigation
| Motion | Description |
|--------|-------------|
| `gg` | Top of file |
| `G` | Bottom of file |
| `{line}G` | Go to line number (e.g., `42G`) |
| `{` | Previous blank line (paragraph up) |
| `}` | Next blank line (paragraph down) |

### Screen Navigation
| Motion | Description |
|--------|-------------|
| `H` | Top of screen (High) |
| `M` | Middle of screen |
| `L` | Bottom of screen (Low) |
| `Ctrl+d` | Half page down |
| `Ctrl+u` | Half page up |
| `Ctrl+f` | Full page down |
| `Ctrl+b` | Full page up |
| `zz` | Center cursor on screen |
| `zt` | Move cursor to top of screen |
| `zb` | Move cursor to bottom of screen |

### Character Search (same line)
| Motion | Description |
|--------|-------------|
| `f{char}` | Find next char (inclusive) |
| `F{char}` | Find previous char (inclusive) |
| `t{char}` | Until next char (exclusive) |
| `T{char}` | Until previous char (exclusive) |
| `;` | Repeat last f/F/t/T |
| `,` | Repeat last f/F/t/T backwards |

**Example**: `df,` = Delete from cursor to next comma (inclusive)

---

## Operators

Operators act on motions or text objects:

| Operator | Description |
|----------|-------------|
| `d` | Delete (cut) |
| `c` | Change (delete and enter insert) |
| `y` | Yank (copy) |
| `v` | Visual select |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `gU` | Uppercase |
| `gu` | Lowercase |
| `~` | Toggle case |

### Common Operator Combinations
| Command | Description |
|---------|-------------|
| `dd` | Delete line |
| `yy` | Yank line |
| `cc` | Change line |
| `D` | Delete to end of line (same as `d$`) |
| `C` | Change to end of line (same as `c$`) |
| `Y` | Yank line (same as `yy`) |
| `x` | Delete character (same as `dl`) |
| `s` | Substitute character (same as `cl`) |
| `S` | Substitute line (same as `cc`) |

---

## Text Objects

Text objects define boundaries for operators. Format: `[a|i][object]`

- `a` = "around" (includes delimiters/whitespace)
- `i` = "inner" (excludes delimiters/whitespace)

### Word/WORD
| Text Object | Description |
|-------------|-------------|
| `iw` | Inner word |
| `aw` | A word (includes trailing space) |
| `iW` | Inner WORD |
| `aW` | A WORD (includes trailing space) |

**Examples:**
- `ciw` - Change inner word (cursor anywhere in word)
- `daw` - Delete a word (includes space)
- `yiw` - Yank inner word

### Quotes/Brackets
| Text Object | Description |
|-------------|-------------|
| `i"` | Inside double quotes |
| `a"` | Around double quotes (includes quotes) |
| `i'` | Inside single quotes |
| `a'` | Around single quotes |
| `i\`` | Inside backticks |
| `a\`` | Around backticks |
| `i(` or `i)` or `ib` | Inside parentheses |
| `a(` or `a)` or `ab` | Around parentheses |
| `i[` or `i]` | Inside square brackets |
| `a[` or `a]` | Around square brackets |
| `i{` or `i}` or `iB` | Inside curly braces |
| `a{` or `a}` or `aB` | Around curly braces |
| `i<` or `i>` | Inside angle brackets |
| `a<` or `a>` | Around angle brackets |
| `it` | Inside XML/HTML tag |
| `at` | Around XML/HTML tag |

**Examples:**
- `ci"` - Change inside quotes
- `da(` - Delete around parentheses (including parens)
- `yi{` - Yank inside braces
- `dit` - Delete inside HTML tag

### Sentences/Paragraphs
| Text Object | Description |
|-------------|-------------|
| `is` | Inner sentence |
| `as` | A sentence |
| `ip` | Inner paragraph |
| `ap` | A paragraph |

---

## Powerful Combinations

### Common Workflows

**Change inside word** (cursor anywhere on word):
```
ciw
```

**Delete entire line and paste**:
```
dd
p
```

**Delete line without copying to clipboard** (uses black hole register):
```
"_dd
```

**Copy line and paste from system clipboard**:
```
"+yy
"+p
```

**Select entire file**:
```
ggVG
```

**Copy entire file to system clipboard**:
```
ggVG"+y
```

**Delete inside quotes and paste something else**:
```
di"    (delete inside quotes)
i      (enter insert mode)
{type new text}
Esc
```

**Change surrounding quotes from double to single**:
```
di"    (delete inside double quotes)
i'{text}'
```
(Or use vim-surround plugin: `cs"'`)

**Indent entire file**:
```
ggVG=
```

**Duplicate a line**:
```
yyp
```

**Swap two words**:
```
dawwP
```
- `daw` - Delete a word (including space)
- `w` - Move to next word
- `P` - Paste before cursor

**Delete from cursor to end of line**:
```
D     (or d$)
```

**Change from cursor to end of line**:
```
C     (or c$)
```

**Join line below to current line**:
```
J
```

**Toggle case of entire word**:
```
viw~
```

---

## Registers

Vim has multiple clipboards called "registers". Access with `"` prefix.

| Register | Description |
|----------|-------------|
| `"` | Default (unnamed) register |
| `+` | System clipboard (Cmd+V compatible) |
| `*` | Primary selection (X11/Linux) |
| `_` | Black hole (delete without copying) |
| `0` | Last yank (not deleted text) |
| `1-9` | Last 9 deletions |
| `a-z` | Named registers (user-defined) |
| `"` | Last used register |
| `:` | Last command |
| `/` | Last search |

### Register Usage

**Copy to system clipboard**:
```
"+yy      (yank line to clipboard)
"+yiw     (yank word to clipboard)
ggVG"+y   (copy entire file)
```

**Paste from system clipboard**:
```
"+p       (paste after cursor)
"+P       (paste before cursor)
```

**Delete without affecting clipboard**:
```
"_dd      (delete line to black hole)
"_dw      (delete word to black hole)
```

**Paste last yanked text** (even after deleting):
```
"0p       (paste from yank register)
```

**Use named register**:
```
"ayy      (yank line to register 'a')
"ap       (paste from register 'a')
"Ayy      (append line to register 'a')
```

---

## Visual Mode

Enter visual mode to select text, then operate on selection.

| Mode | Key | Description |
|------|-----|-------------|
| Visual (character) | `v` | Select characters |
| Visual Line | `V` | Select lines |
| Visual Block | `Ctrl+v` | Select rectangular block |

### Visual Mode Operations

**After entering visual mode, use motions to extend selection:**
- `v3w` - Select 3 words
- `Vjjj` - Select 4 lines
- `vi"` - Select inside quotes
- `vit` - Select inside HTML tag

**Common visual operations:**
```
viw      (select word)
y        (yank/copy)

Vjjj     (select 4 lines)
d        (delete)

ggVG     (select entire file)
=        (auto-indent)

Ctrl+v   (block select)
jjjj     (select multiple lines)
I        (insert at start of each line)
// {type text}
Esc      (applies to all lines)
```

### Visual Mode Tips

**Replace without yanking deleted text**:
```
viwp     (select word and paste, deleted text goes to register)
```

**Better: use black hole register**:
```
viw"_dP  (delete to black hole, paste from previous yank)
```

**Or in your config** (already set):
```lua
-- Paste over selection without yanking replaced text
keymap("x", "p", '"_dP', opts)
```

---

## Search & Replace

### Search
| Command | Description |
|---------|-------------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |
| `g*` | Search partial word under cursor (forward) |
| `g#` | Search partial word under cursor (backward) |

### Replace
| Command | Description |
|---------|-------------|
| `:s/old/new` | Replace first on line |
| `:s/old/new/g` | Replace all on line |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:'<,'>s/old/new/g` | Replace in visual selection |

---

## Numbers & Counts

Prefix any motion/operator with a number to repeat it:

| Command | Description |
|---------|-------------|
| `3w` | Move 3 words forward |
| `5j` | Move 5 lines down |
| `2dd` | Delete 2 lines |
| `3p` | Paste 3 times |
| `10itext<Esc>` | Insert "text" 10 times |
| `d3w` | Delete 3 words |
| `c2}` | Change 2 paragraphs |

**Examples:**
```
d5j      (delete 5 lines down)
y3k      (yank 3 lines up)
c4w      (change 4 words)
10==     (auto-indent 10 lines)
3>>      (indent 3 lines right)
```

---

## Macros

Record and replay sequences of commands:

| Command | Description |
|---------|-------------|
| `qa` | Start recording to register 'a' |
| `q` | Stop recording |
| `@a` | Play macro from register 'a' |
| `@@` | Replay last macro |
| `10@a` | Play macro 10 times |

**Example workflow:**
```
qa          (start recording to 'a')
0           (go to start of line)
i// <Esc>   (insert comment)
j           (move down)
q           (stop recording)

@a          (replay - comments next line)
3@a         (replay 3 times - comments 3 more lines)
```

---

## Marks & Jumps

### Marks
| Command | Description |
|---------|-------------|
| `ma` | Set mark 'a' at cursor |
| `` `a `` | Jump to mark 'a' (exact position) |
| `'a` | Jump to mark 'a' (line start) |
| `:marks` | List all marks |

**Special marks:**
- `` `. `` - Last change
- `` `" `` - Last exit position
- `` `[ `` - Start of last change/yank
- `` `] `` - End of last change/yank

### Jump List
| Command | Description |
|---------|-------------|
| `Ctrl+o` | Jump to previous location |
| `Ctrl+i` | Jump to next location |
| `:jumps` | Show jump list |

---

## Advanced Patterns

### Change/Delete Until Character
```
ct,     (change until comma)
dt)     (delete until closing paren)
cf;     (change including semicolon)
```

### Operate on Entire Function/Block
```
va{     (visual select around braces)
di{     (delete inside braces)
ci{     (change inside braces)
=i{     (auto-indent inside braces)
```

### Multi-line Editing (Visual Block)
```
Ctrl+v       (enter visual block)
jjjj         (select 4 lines)
I            (insert at start)
// {text}    (type comment)
Esc          (applies to all lines)
```

### Search and Replace Word Under Cursor
```
*           (search for word)
:%s//new/g  (replace all - pattern from search)
```

### Swap Lines
```
ddp         (delete line and paste below)
ddkP        (delete line and paste above)
```

### Increment/Decrement Numbers
```
Ctrl+a      (increment number under cursor)
Ctrl+x      (decrement number under cursor)
10Ctrl+a    (increment by 10)
```

---

## Common Mistakes & Solutions

### Problem: Deleted text replaced clipboard
**Solution**: Use black hole register
```
"_dd    (delete without copying)
```

### Problem: Want to paste multiple times
**Solution**: Use yank register after first paste
```
yy      (yank)
p       (paste)
"0p     (paste from yank register again)
```

### Problem: Need to change text in quotes
**Wrong**: Move to quote, delete, type new text
**Right**:
```
ci"     (change inside quotes from anywhere)
```

### Problem: Want to select entire function
**Wrong**: Visual mode + manually select
**Right**:
```
va{     (visual around braces)
```

### Problem: Accidentally entered visual mode
**Solution**:
```
Esc     (exit visual mode)
```

---

## Pro Tips

1. **Use text objects over motions** - `ciw` instead of `bcw`
2. **Use relative line numbers** - Jump with `5j` instead of pressing `j` 5 times
3. **Learn to use `.` (repeat)** - Makes repeating last change instant
4. **Use `*` for word search** - Faster than typing `/word`
5. **Master `ci"`, `ci(`, `ci{`** - Huge productivity boost
6. **Use `A` to append at end of line** - Saves `$a`
7. **Use `I` to insert at start of line** - Saves `^i`
8. **Use `o`/`O` to open new lines** - Faster than `A<Enter>`
9. **Use `f` for horizontal movement** - `f,` to jump to comma
10. **Combine operators with counts** - `d3w` instead of `dwdwdw`

---

## Quick Reference Card

**Most Used (Learn These First):**
```
hjkl        - Basic movement
w/b         - Word movement
ciw         - Change word
di"/ci"     - Delete/change inside quotes
dd/yy       - Delete/yank line
p/P         - Paste after/before
u/Ctrl+r    - Undo/redo
/           - Search
n/N         - Next/previous search
*/#         - Search word under cursor
ggVG        - Select all
"+y/"+p     - System clipboard copy/paste
```

**Essential Combos:**
```
ciw         - Change inner word
daw         - Delete a word (with space)
ci"         - Change inside quotes
da(         - Delete around parentheses
ggVG"+y     - Copy entire file to clipboard
"_dd        - Delete without copying
diw"0p      - Delete word, paste previous yank
```

---

## Configuration Notes

Your VSCode setup already has these enhancements:

**Clipboard sync**:
```lua
vim.opt.clipboard = "unnamedplus"
```
- Normal `y` copies to system clipboard
- Normal `p` pastes from system clipboard

**Visual paste improvement**:
```lua
keymap("x", "p", '"_dP', opts)
```
- Paste in visual mode without yanking replaced text

**Center on scroll**:
```lua
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)
```
- Keeps cursor centered when scrolling

**Quick insert mode exit**:
```lua
keymap("i", "jj", "<Esc>", opts)
keymap("i", "jk", "<Esc>", opts)
```
- Type `jj` or `jk` to exit insert mode

---

## Resources

- `:help motion.txt` - Vim motion help
- `:help text-objects` - Text object help
- `:help registers` - Register help
- `vimtutor` - Interactive vim tutorial (in terminal)
- [Vim Cheat Sheet](https://vim.rtorr.com/)
- [Learn Vim (the Smart Way)](https://github.com/iggredible/Learn-Vim)
