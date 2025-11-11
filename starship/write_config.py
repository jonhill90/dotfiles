#!/usr/bin/env python3
"""
Write Starship configuration with proper Unicode/Nerd Font symbols.
Using Python to preserve special characters that would be stripped by direct writes.
"""

config = '''"$schema" = 'https://starship.rs/config-schema.json'

# Single-line format matching P10k layout:
# os_icon -> directory -> git_branch -> git_status -> prompt_char
format = """
$os\
$directory\
$git_branch\
$git_status\
$character"""

# OS icon (enabled, shows Apple logo on macOS)
[os]
disabled = false
format = "[$symbol]($style)"
style = "bold white"

[os.symbols]
Macos = "\uf179 "       # Apple logo (Nerd Font)
Windows = "\ue62a "     # Windows logo (Nerd Font)
Arch = "\uf303 "        # Arch logo
Linux = "\uf17c "       # Generic Linux penguin
Ubuntu = "\uf31b "      # Ubuntu logo
Debian = "\uf306 "      # Debian logo
Fedora = "\uf30a "      # Fedora logo
Unknown = "\uf059 "     # Question mark

# Directory (blue, truncated like P10k)
[directory]
style = "bold cyan"
truncation_length = 3
truncate_to_repo = true
format = "[$path]($style) "
repo_root_style = "bold cyan"

# Git branch with Nerd Font icon (matching P10k's U+F126)
[git_branch]
symbol = "\uf126 "      # Git branch icon (matches P10k)
format = "[$symbol$branch]($style) "
style = "bright-black"
truncation_length = 20

# Git status (minimal, cyan like P10k right prompt)
[git_status]
format = "[$all_status$ahead_behind]($style)"
style = "cyan"
conflicted = "="
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
untracked = "?"
stashed = "$"
modified = "!"
staged = "+"
renamed = "»"
deleted = "✘"

# Prompt character (❯ green/red, ❮ for vi mode)
[character]
success_symbol = "[\u276f](bold green)"     # ❯ green on success
error_symbol = "[\u276f](bold red)"         # ❯ red on error
vimcmd_symbol = "[\u276e](bold green)"      # ❮ green in vi command mode

# Disable modules not in P10k left prompt
# (These were on the right prompt in P10k)
[username]
disabled = true

[hostname]
disabled = true

[cmd_duration]
disabled = true

[python]
disabled = true

[nodejs]
disabled = true

[rust]
disabled = true

[golang]
disabled = true

[package]
disabled = true

[time]
disabled = true
'''

if __name__ == "__main__":
    import os

    output_path = os.path.join(
        os.path.dirname(__file__),
        ".config",
        "starship.toml"
    )

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(config)

    print(f"✅ Starship config written to: {output_path}")
    print("🔍 Unicode test:")
    print(f"   Apple logo: \uf179")
    print(f"   Git branch: \uf126")
    print(f"   Prompt: \u276f / \u276e")
