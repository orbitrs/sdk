# Orbit Framework PowerShell Development Runner
# Optimized for rapid Windows development

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("check", "test", "build", "dev", "format", "lint", "rapid")]
    [string]$Task
)

function Write-TimedLog {
    param([string]$Message, [string]$Level = "INFO")
    
    $timestamp = Get-Date -Format "HH:mm:ss"
    $colors = @{
        "INFO" = "Cyan"
        "SUCCESS" = "Green" 
        "ERROR" = "Red"
        "WARNING" = "Yellow"
    }
    
    Write-Host "[$timestamp] [$Level] $Message" -ForegroundColor $colors[$Level]
}

function Invoke-TimedCommand {
    param([string]$Command, [string]$Description)
    
    Write-TimedLog "Starting: $Description"
    $startTime = Get-Date
    
    try {
        Invoke-Expression $Command
        if ($LASTEXITCODE -eq 0) {
            $duration = (Get-Date) - $startTime
            Write-TimedLog "✅ $Description completed in $($duration.TotalSeconds.ToString('F2'))s" "SUCCESS"
            return $true
        } else {
            $duration = (Get-Date) - $startTime
            Write-TimedLog "❌ $Description failed in $($duration.TotalSeconds.ToString('F2'))s" "ERROR"
            return $false
        }
    } catch {
        $duration = (Get-Date) - $startTime
        Write-TimedLog "❌ $Description failed in $($duration.TotalSeconds.ToString('F2'))s: $($_.Exception.Message)" "ERROR"
        return $false
    }
}

# Task implementations
function Invoke-FastCheck {
    return Invoke-TimedCommand "cargo check --workspace" "Fast workspace check"
}

function Invoke-TestSuite {
    return Invoke-TimedCommand "cargo test --workspace" "Test suite"
}

function Invoke-BuildAll {
    return Invoke-TimedCommand "cargo build --workspace" "Build all crates"
}

function Invoke-DevServer {
    Write-TimedLog "Starting development server with hot reload..."
    return Invoke-TimedCommand "cargo watch -x 'run --bin orbiton -- dev'" "Development server"
}

function Invoke-FormatCode {
    return Invoke-TimedCommand "cargo fmt --all" "Code formatting"
}

function Invoke-LintCode {
    return Invoke-TimedCommand "cargo clippy --workspace --all-targets -- -D warnings" "Code linting"
}

function Invoke-RapidIteration {
    Write-TimedLog "🚀 Starting rapid iteration cycle" "INFO"
    $totalStart = Get-Date
    
    $tasks = @(
        @{ Name = "Format"; Function = { Invoke-FormatCode } },
        @{ Name = "Check"; Function = { Invoke-FastCheck } },
        @{ Name = "Lint"; Function = { Invoke-LintCode } },
        @{ Name = "Test"; Function = { Invoke-TestSuite } },
        @{ Name = "Build"; Function = { Invoke-BuildAll } }
    )
    
    foreach ($task in $tasks) {
        if (-not (& $task.Function)) {
            Write-TimedLog "❌ Rapid iteration failed at: $($task.Name)" "ERROR"
            return $false
        }
    }
    
    $totalTime = (Get-Date) - $totalStart
    Write-TimedLog "🎉 Rapid iteration completed in $($totalTime.TotalSeconds.ToString('F2'))s" "SUCCESS"
    return $true
}

# Main execution
$success = switch ($Task) {
    "check" { Invoke-FastCheck }
    "test" { Invoke-TestSuite }
    "build" { Invoke-BuildAll }
    "dev" { Invoke-DevServer }
    "format" { Invoke-FormatCode }
    "lint" { Invoke-LintCode }
    "rapid" { Invoke-RapidIteration }
}

if (-not $success) {
    exit 1
}
