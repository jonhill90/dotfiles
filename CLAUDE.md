# CLAUDE.md

AI assistant guidance for working with this dotfiles repository.

## Overview

**macOS dotfiles repository** managed with GNU Stow. Tracks configs for: zsh, Neovim, tmux, herdr, AeroSpace, Ghostty, VSCode, and Homebrew.

`AGENT.md` is a symlink to this file, so harnesses looking for either name get the same guidance. Edit `CLAUDE.md`; never replace the symlink with a copy.

## Critical Constraints

**MUST READ BEFORE CHANGES:**
1. **Target location**: Repository lives at `~/.dotfiles`, always use `stow --target="$HOME"`
2. **Not all configs use `~/.config/`**: AeroSpace uses `~/.aerospace.toml` (home directory)
3. **External dependencies required**: Oh My Zsh, TPM (Tmux Plugin Manager), Homebrew (see Architecture)
4. **Machine-specific overrides**: Never commit `.gitconfig.local`, `.zshrc.local`, `.tmux.conf.local`
5. **Obsidian context exists**: Use `mcp__basic-memory__read_note` to read project/research notes before making assumptions

## Obsidian Knowledge Base

**Before making changes, read relevant notes to understand context and decisions:**

**Primary Project Notes:**
- `03-projects/03b-personal/project-personal-dot-files` - Main project scope, tasks, timeline
- `03-projects/03b-personal/project-personal-[tool]-configuration` - Tool-specific projects (aerospace, tmux, neovim)
- `03-projects/03b-personal/project-personal-gnu-stow` - Stow patterns and best practices

**Research Notes (for technical deep-dives):**
- `01-notes/01r-research/202510312014` - GNU Stow hands-on session (2025-10-31)
- `01-notes/01r-research/202510300130` - Current config audit (2025-10-30)
- `01-notes/01r-research/20251029234[1-8]` - Tool-specific research (Neovim, tmux, Stow, etc.)

**When to read these:**
- Before proposing architecture changes
- When debugging why something is configured a certain way
- Before suggesting alternatives to current tools
- When planning new features or packages

## Architecture

### GNU Stow Pattern
```
package_name/.target/path/config_file
```
Each directory is a "package" mirroring home directory structure.
- `zsh/.zshrc` → `~/.zshrc`
- `nvim/.config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `aerospace/.aerospace.toml` → `~/.aerospace.toml` (NOT `.config/`)

### External Dependencies (Required)
Must be installed separately:
- **Homebrew** - Package manager (installs all tools via Brewfile)
- **Oh My Zsh** - Shell framework (manual install)
- **TPM** - Tmux Plugin Manager (clone to `~/.tmux/plugins/tpm`)

### Machine-Specific Overrides (Gitignored)
- `~/.gitconfig.local` - Email, name
- `~/.zshrc.local` - Shell customizations
- `~/.tmux.conf.local` - tmux overrides (optional)

## Packages

### Neovim (nvim)
- **Base**: LazyVim (curated Neovim distribution)
- **Theme**: Tokyo Night (`tokyonight-night`)
- **LSPs**: Terraform, Lua (via Mason)
- **Plugins**: lazy.nvim manager (`lazy-lock.json` gitignored)
- **Leader**: Space
- **VSCode Integration**: Conditional loading via `vim.g.vscode` flag
  - Terminal: Full LazyVim (`config.lazy`)
  - VSCode: Minimal config with VSCode actions (`config.vscode`)
- **Custom dirs**: `lua/config/`, `lua/plugins/`
- **Keybinds**: Standard HJKL, Space leader (see `docs/nvim-shortcuts.md`, `docs/vscode-shortcuts.md`)

### AeroSpace (aerospace)
- **Config**: `~/.aerospace.toml` (NOT in `.config/`)
- **App launchers**: `Shift-Ctrl-Alt-Cmd` + letter (A=Ghostty, B=Arc, C=Claude, D=Discord, etc.)
- **Workspaces**: 1-5 main monitor, 6-10 secondary monitor
- **Floating**: Finder, Bitwarden, Teams, Outlook
- **Service mode**: `Alt+Shift+;` for reload/reset
- **Keybinds**: `Alt+HJKL` (focus), `Alt+Shift+HJKL` (move)

### tmux (tmux)
- **Config**: Minimal custom (~120 lines) at `~/.tmux.conf`
- **Theme**: Tokyo Night with transparency (`fabioluciano/tmux-tokyo-night`)
  - ⚠️ **PIN to v1.11.0**: `cd ~/.tmux/plugins/tmux-tokyo-night && git checkout v1.11.0`. The plugin was rewritten ("powerkit", v5.x) with a breaking `@theme_*` → `@powerkit_*` config change and the new version renders windows as connected segments. v1.11.0 keeps the **isolated rounded window pills** + keyboard session icon this config is built for. **Do NOT `prefix + U`** (it updates to the broken-look version).
  - 🍎 **macOS PATH guard** (in `.tmux.conf`): macOS launches the tmux server without `/opt/homebrew/bin` on PATH, so the theme's `run-shell` scripts can't find `tmux`/`jq` and the bar falls back to **green**. An `if-shell '[ -d /opt/homebrew/bin ]'` line sets PATH before plugins load. No-op on Linux/WSL.
- **Prefix**: `Ctrl+b` (default) or `Ctrl+a` (secondary)
- **Vi-mode**: Enabled for copy mode
- **Custom binds**: `|` vertical split, `-` horizontal split, `r` reload, `e` edit config
- **Plugins** (TPM): tmux-tokyo-night (theme), vim-tmux-navigator, tmux-yank, tmux-resurrect, tmux-continuum, tmux-fzf-url, tmux-sessionx
- **Key features**: Dual prefix, mouse support, status bar on top, seamless nvim integration
- **Keybinds**: `Ctrl+HJKL` navigation (see `docs/tmux-shortcuts.md`)

### herdr (herdr)
- **Config**: `~/.config/herdr/config.toml` (XDG standard, stows normally)
- **What it is**: Terminal workspace manager for AI coding agents; server/client with detach
- **Model**: workspace ("space") → tab → pane, mapping to tmux session → window → pane
- **Prefix**: `Ctrl+a` only — herdr supports a single prefix and has **no `send-prefix`**, so literal `Ctrl+a` is unreachable inside panes
- **Bindings**: Deliberately mirror `.tmux.conf` (`|`/`-` splits, `hjkl` focus, `r` reload, `o` space picker, `d` detach, `C-h`/`C-l` tabs)
- **Theme**: `tokyo-night` (matches tmux, Neovim, VSCode)
- **Validate before reload**: `herdr config check` — but note it only compares bindings you explicitly set, **not** against unstated defaults, so a binding that collides with a default can pass as `ok`. Write related keys out explicitly.
- **Runtime files** (`session.json`, `*.sock`, `*.log`) live in `~/.config/herdr/` and must never be committed; stow links only `config.toml`
- **Known gaps**: no vi copy mode (mouse-first), no `vim-tmux-navigator` equivalent, no `last_tab`/`last_workspace`/pane-swap actions
- **Keybinds**: see `docs/herdr-shortcuts.md`

### Ghostty (ghostty)
- **Config**: `~/.config/ghostty/config` (XDG standard)
- **Font**: FiraCode Nerd Font 16pt (thicken enabled)
- **Appearance**: 0.9 opacity with blur, Display-P3 color space
- **Theme**: iTerm2 Default
- **Custom**: macOS dock icon, hidden tab bar (using tmux), `super+t=ignore`

### Zsh (zsh)
- **Files**: `.zshrc` (127 lines) + `.p10k.zsh` (89KB Powerlevel10k)
- **Framework**: Oh My Zsh (minimal plugins: git only)
- **Theme**: Powerlevel10k
- **FZF**: Integrated with `ag` (silver searcher)
- **Aliases**: `inv` (nvim+fzf+bat), `vi` (nvim), `cdsp` (`claude --dangerously-skip-permissions`)

### VSCode (vscode)
- **Config**: `~/.dotfiles/vscode/` (simple structure, not stow-based)
- **Extension**: vscode-neovim (embeds actual Neovim instance)
- **Font**: FiraCode Nerd Font with ligatures (matches terminal setup)
- **Symlinking**: OS-specific in install.sh
  - macOS: `~/Library/Application Support/Code/User/`
  - Linux: `~/.config/Code/User/`
- **Keybinds**: LazyVim-inspired semantic mappings (see `docs/vscode-shortcuts.md`)
- **Integration**: Conditional Neovim config loads `lua/config/vscode.lua` when in VSCode
- **Philosophy**: VSCode for debugging/GUI tasks, terminal Neovim for K8s/DevOps/SSH

### Git (git)
- Minimal base config
- Machine-specific in `~/.gitconfig.local` (gitignored)

## Workflows

### Initial Setup (New Machine)
```bash
# Clone and run installer
git clone https://github.com/jonhill90/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh

# Install TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Reload and install tmux plugins
exec zsh
tmux
# Press: prefix + I (to install plugins)

# Pin the Tokyo Night theme to the version this config targets (see tmux section).
# Without this the status bar uses the rewritten "powerkit" version (wrong look).
cd ~/.tmux/plugins/tmux-tokyo-night && git checkout v1.11.0 && cd ~/.dotfiles
tmux kill-server   # restart so the themed bar (rounded pills) renders

# Press: Alt+Shift+; then Escape (reload AeroSpace)
```

### Daily Operations

**Edit configs** - Changes reflect immediately via symlinks:
```bash
cd ~/.dotfiles/package/
nvim .config/package/config  # Edit directly in repo
```

**Add new package:**
```bash
mkdir -p newapp/.config/newapp
cp ~/.config/newapp/config newapp/.config/newapp/
stow --target="$HOME" newapp
```

**Update Brewfile after installing packages:**
```bash
brew bundle dump --describe --force
```

**Stow operations:**
```bash
stow --target="$HOME" package      # Create symlinks
stow -D --target="$HOME" package   # Remove symlinks
stow -R --target="$HOME" package   # Recreate symlinks
```

### Testing/Reloading

- **AeroSpace**: `Alt+Shift+;` then `Escape` (or `brew services restart aerospace`)
- **tmux**: `prefix r` (shows checkmark on status bar) or `tmux source-file ~/.tmux.conf`
- **herdr**: `herdr config check` first, then `prefix r` or `herdr server reload-config`
- **Neovim**: `:checkhealth`
- **Zsh**: `exec zsh`
- **tmux plugins**: `prefix I` (install), `prefix U` (update)

### Troubleshooting

- **Symlink conflicts**: Backup first (`mv ~/.zshrc ~/.zshrc.backup`), then restow
- **Neovim plugins broken**: `:checkhealth` then `:Lazy restore`
- **tmux config not applying**: `prefix r` or `tmux kill-server` then restart
- **tmux plugins not loading**: `prefix I` to install, check `~/.tmux/plugins/tpm` exists
- **tmux status bar is green / wrong (macOS)**: theme couldn't run — (1) confirm theme pinned to v1.11.0 (`git -C ~/.tmux/plugins/tmux-tokyo-night describe --tags`); (2) the `.tmux.conf` macOS PATH guard must be present (theme needs `/opt/homebrew/bin` for `tmux`/`jq`); (3) `tmux kill-server` — a stale server won't re-theme. Clear `~/.cache/tmux-powerkit` if it was ever on the new plugin version.
- **tmux windows not rounded pills**: theme drifted off v1.11.0 (likely a `prefix + U`). Re-checkout v1.11.0 and `tmux kill-server`.
- **Verify symlink**: `ls -la ~/.config/app` (should show `l` and `->`)

## Current State

**Implemented:**
- LazyVim with Tokyo Night theme (terminal + VSCode integration)
- VSCode with vscode-neovim (semantic keybindings matching LazyVim)
- Powerlevel10k + Tokyo Night theme (shell + Neovim + tmux + VSCode)
- Ghostty terminal with GPU acceleration + transparency
- Custom minimal tmux config (115 lines) + TPM plugins
- herdr agent workspace manager with tmux-mirrored keybindings
- Terraform & Lua LSPs only
- Modern CLI tools: zoxide, atuin, carapace, fzf
- Starship prompt

**Roadmap** (not yet implemented):
- Catppuccin theme, WezTerm
- Additional LSPs (Python, JSON, YAML, Shell, K8s)
- Shell vi-mode, bootstrap improvements

## Documentation

- **README.md** - Quick start and overview
- **docs/nvim-shortcuts.md** - Neovim keybindings reference (LazyVim)
- **docs/vscode-shortcuts.md** - VSCode + vscode-neovim keybindings reference
- **docs/tmux-shortcuts.md** - tmux keybindings reference
- **docs/herdr-shortcuts.md** - herdr keybindings reference + tmux differences
