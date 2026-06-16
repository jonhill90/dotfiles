# PowerShell profile — AllHosts (console, VSCode, ISE)
# Tracked in dotfiles. Stowed to ~/.config/powershell/profile.ps1 on macOS.
# Machine-specific overrides go in Microsoft.PowerShell_profile_local.ps1 (gitignored).

# Zoxide (smart directory jumping)
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# Starship prompt — skip ISE (no ANSI prompt support)
$env:STARSHIP_CONFIG = "$HOME/.dotfiles/starship/.config/starship.toml"
if (($Host.Name -ne 'Windows PowerShell ISE Host') -and (Get-Command starship -ErrorAction SilentlyContinue)) {
    Invoke-Expression (& starship init powershell)
}

# Source local config (not tracked in git) — auto-create if missing
$localProfile = Join-Path $PSScriptRoot "Microsoft.PowerShell_profile_local.ps1"
if (-not (Test-Path $localProfile)) {
    @"
# Local PowerShell profile — not tracked in git
# Add machine-specific environment variables, aliases, or overrides here.
"@ | Set-Content -Path $localProfile -Encoding UTF8
}
. $localProfile
