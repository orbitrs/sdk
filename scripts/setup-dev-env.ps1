# Orbit Framework Development Environment
# Auto-generated development setup script

Write-Host "🚀 Setting up Orbit Framework Development Environment" -ForegroundColor Cyan

# Install required Rust targets for cross-platform development
Write-Host "📦 Installing Rust targets..." -ForegroundColor Yellow
rustup target add wasm32-unknown-unknown
rustup target add aarch64-apple-darwin
rustup target add x86_64-apple-darwin
rustup target add aarch64-unknown-linux-gnu
rustup target add x86_64-unknown-linux-gnu

# Install essential development tools
Write-Host "🔧 Installing development tools..." -ForegroundColor Yellow
cargo install cargo-watch          # For hot reloading
cargo install cargo-edit           # For easy dependency management
cargo install cargo-outdated       # For dependency updates
cargo install wasm-pack           # For WebAssembly builds

# Create development directories
Write-Host "📁 Setting up development directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path "target\dev"
New-Item -ItemType Directory -Force -Path "target\release"
New-Item -ItemType Directory -Force -Path ".vscode"

# Generate VS Code settings for optimal development
$vscodeSettings = @"
{
    "rust-analyzer.cargo.features": "all",
    "rust-analyzer.check.command": "check",
    "rust-analyzer.check.allTargets": false,
    "rust-analyzer.diagnostics.experimental.enable": true,
    "rust-analyzer.completion.privateEditable.enable": true,
    "files.watcherExclude": {
        "**/target/**": true
    },
    "search.exclude": {
        "**/target": true,
        "**/Cargo.lock": true
    }
}
"@

$vscodeSettings | Out-File -FilePath ".vscode\settings.json" -Encoding UTF8

Write-Host "✅ Development environment setup complete!" -ForegroundColor Green
Write-Host "🏃‍♂️ Ready for rapid development!" -ForegroundColor Cyan
