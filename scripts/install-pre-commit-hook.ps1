#!/usr/bin/env pwsh
# Install the pre-commit hook for beta compatibility checking

$ErrorActionPreference = "Stop"

# Define paths
$scriptDir = Split-Path -Parent $PSCommandPath
$repoRoot = Split-Path -Parent $scriptDir
$hookSource = Join-Path $scriptDir "pre-commit-hook"
$hookTarget = Join-Path $repoRoot ".git" "hooks" "pre-commit"

# Ensure .git/hooks directory exists
$hooksDir = Split-Path -Parent $hookTarget
if (-not (Test-Path $hooksDir)) {
    Write-Host "Creating hooks directory: $hooksDir" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
}

# Copy the hook
Write-Host "📝 Installing beta compatibility pre-commit hook..." -ForegroundColor Blue
Copy-Item -Path $hookSource -Destination $hookTarget -Force

# Make executable on Unix-like systems (doesn't affect Windows)
if ($IsLinux -or $IsMacOS) {
    chmod +x $hookTarget
    Write-Host "✅ Made hook executable" -ForegroundColor Green
}

Write-Host "✅ Pre-commit hook installed successfully!" -ForegroundColor Green
Write-Host "Now git will check for beta compatibility issues before each commit." -ForegroundColor Green
