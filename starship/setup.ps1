<#
.SYNOPSIS
Configures the Starship prompt on Windows to use the repo-managed config.

.DESCRIPTION
- Ensures `~/.config/starship.toml` points at the repo version (symlink or copy).
- Sets the `STARSHIP_CONFIG` user environment variable for consistency.
- Adds the `starship init powershell` snippet to the current user's profile.

Run from the repository root:
  pwsh -ExecutionPolicy Bypass -File starship/setup.ps1

.PARAMETER Force
Overwrite existing config/profile entries without creating backups.
#>
[CmdletBinding()]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$repoStarshipDir = $PSScriptRoot
$sourceConfig = Join-Path $repoStarshipDir '.config' 'starship.toml'
if (-not (Test-Path $sourceConfig)) {
    throw "Missing starship config at $sourceConfig"
}

$targetConfigDir = Join-Path $HOME '.config'
$targetConfigPath = Join-Path $targetConfigDir 'starship.toml'

if (-not (Test-Path $targetConfigDir)) {
    New-Item -ItemType Directory -Path $targetConfigDir -Force | Out-Null
}

if (Test-Path $targetConfigPath) {
    if ($Force) {
        Remove-Item -Path $targetConfigPath -Force
    } else {
        $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backupPath = "$targetConfigPath.backup-$timestamp"
        Move-Item -Path $targetConfigPath -Destination $backupPath
        Write-Host "Existing starship config backed up to $backupPath"
    }
}

$linkCreated = $false
try {
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        New-Item -ItemType SymbolicLink -Path $targetConfigPath -Target $sourceConfig -Force | Out-Null
    } else {
        New-Item -ItemType SymbolicLink -Path $targetConfigPath -Value $sourceConfig -Force | Out-Null
    }
    $linkCreated = $true
    Write-Host "Symlink created: $targetConfigPath -> $sourceConfig"
} catch {
    Write-Warning "Symbolic link creation failed ($($_.Exception.Message)). Falling back to copy."
    Copy-Item -Path $sourceConfig -Destination $targetConfigPath -Force
    Write-Host "Config copied to $targetConfigPath"
}

[Environment]::SetEnvironmentVariable('STARSHIP_CONFIG', $sourceConfig, 'User')
Write-Host "User environment variable STARSHIP_CONFIG set to $sourceConfig"

if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Warning "Starship binary not detected. Install via winget install Starship.Starship or scoop install starship."
}

$profilePath = $PROFILE
$profileDir = Split-Path -Parent $profilePath
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

if (-not (Test-Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force | Out-Null
}

$initLine = 'Invoke-Expression (& starship init powershell)'
$profileContent = Get-Content -Path $profilePath -Raw
if ($profileContent -notmatch [Regex]::Escape($initLine)) {
    $snippet = @(
        '',
        '# Added by dotfiles starship setup',
        $initLine
    )
    Add-Content -Path $profilePath -Value $snippet
    Write-Host "Starship init snippet appended to $profilePath"
} else {
    Write-Host "Starship init already present in $profilePath"
}

Write-Host ''
if ($linkCreated) {
    Write-Host "Starship now tracks $sourceConfig via symlink."
} else {
    Write-Host "Starship config copied. Re-run this script after pulling updates."
}
Write-Host 'Restart PowerShell to load the prompt.'
