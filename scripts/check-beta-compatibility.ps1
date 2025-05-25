#!/usr/bin/env pwsh
# Script to check for common beta compatibility issues in Orbit Framework
# Usage: ./scripts/check-beta-compatibility.ps1

# Set error action preference
$ErrorActionPreference = "Stop"

Write-Host "🔍 Checking for beta compatibility issues..." -ForegroundColor Blue

# Check if rustup and beta toolchain are installed
try {
    $rustupVersion = (rustup --version)
    Write-Host "✅ Found rustup: $rustupVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Rustup not found. Please install rustup first." -ForegroundColor Red
    exit 1
}

# Check if beta toolchain is installed
$betaInstalled = (rustup toolchain list) -match "beta"
if (-not $betaInstalled) {
    Write-Host "⚠️ Beta toolchain not found. Installing..." -ForegroundColor Yellow
    rustup toolchain install beta
} else {
    Write-Host "✅ Beta toolchain is installed" -ForegroundColor Green
}

# Update beta toolchain
Write-Host "📦 Updating beta toolchain..." -ForegroundColor Blue
rustup update beta

# Check for uninlined format strings
Write-Host "🔍 Checking for uninlined format strings..." -ForegroundColor Blue
$formatStringFiles = Get-ChildItem -Path . -Include "*.rs" -Recurse | 
    Select-String -Pattern 'format!\("[^"]*{}[^"]*", [^)]+\)' -List | 
    Select-Object -ExpandProperty Path

if ($formatStringFiles.Count -gt 0) {
    Write-Host "⚠️ Found potential uninlined format strings in $($formatStringFiles.Count) files:" -ForegroundColor Yellow
    foreach ($file in $formatStringFiles) {
        Write-Host "  - $file" -ForegroundColor Yellow
    }
    Write-Host "🔧 Consider updating format strings to use the new syntax: format!(\"message: {var}\") instead of format!(\"message: {}\", var)" -ForegroundColor Yellow
} else {
    Write-Host "✅ No uninlined format strings found" -ForegroundColor Green
}

# Check for feature flag correctness
Write-Host "🔍 Checking for feature flag consistency..." -ForegroundColor Blue

# Load orbiton features
$orbitonCargo = Get-Content -Path "./orbiton/Cargo.toml" -Raw
if ($orbitonCargo -match "\[features\](.*?)\[") {
    $features = $Matches[1]
    Write-Host "📋 orbiton features: $features" -ForegroundColor Blue
} else {
    Write-Host "⚠️ Could not parse orbiton features" -ForegroundColor Yellow
}

# Check CI workflow for correct feature usage
$ciWorkflow = Get-Content -Path "./.github/workflows/ci.yml" -Raw
if ($ciWorkflow -match "cargo test -p orbiton --features desktop") {
    Write-Host "❌ CI workflow using invalid feature 'desktop' for orbiton package" -ForegroundColor Red
    Write-Host "   Recommendation: Remove '--features desktop' from orbiton test command in CI workflow" -ForegroundColor Yellow
} else {
    Write-Host "✅ No invalid feature flags found in CI workflow for orbiton" -ForegroundColor Green
}

# Run cargo check with beta toolchain for all packages
Write-Host "🔍 Running cargo check with beta toolchain..." -ForegroundColor Blue
try {
    # Save current directory
    $currentDir = Get-Location
    
    # Run in orbit directory
    Set-Location -Path "./orbit"
    Write-Host "📦 Checking orbit package..." -ForegroundColor Blue
    cargo +beta check --features desktop
    
    # Run in orlint directory
    Set-Location -Path "../orlint"
    Write-Host "📦 Checking orlint package..." -ForegroundColor Blue
    cargo +beta check
    
    # Run in orbiton directory
    Set-Location -Path "../orbiton"
    Write-Host "📦 Checking orbiton package..." -ForegroundColor Blue
    cargo +beta check
    
    # Run in examples directory
    Set-Location -Path "../examples"
    Write-Host "📦 Checking examples package..." -ForegroundColor Blue
    cargo +beta check --features desktop
    
    # Restore directory
    Set-Location -Path $currentDir
    
    Write-Host "✅ All packages checked with beta toolchain" -ForegroundColor Green
} catch {
    Write-Host "❌ Error checking packages with beta toolchain: $_" -ForegroundColor Red
    # Restore directory
    Set-Location -Path $currentDir
    exit 1
}

Write-Host "✅ Beta compatibility check complete" -ForegroundColor Green
