#!/bin/zsh
# Script to start both the Orbit development server and MCP server

# Default ports
DEV_PORT=8000
MCP_PORT=3000

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dev-port)
            DEV_PORT="$2"
            shift 2
            ;;
        --mcp-port)
            MCP_PORT="$2"
            shift 2
            ;;
        --project-dir)
            PROJECT_DIR="$2"
            shift 2
            ;;
        --help)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --dev-port PORT    Set development server port (default: 8000)"
            echo "  --mcp-port PORT    Set MCP server port (default: 3000)"
            echo "  --project-dir DIR  Set project directory (default: current directory)"
            echo "  --help             Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Determine project directory
if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR=$(pwd)
fi

# Print startup information
echo "🚀 Starting Orbit development environment"
echo "📁 Project directory: $PROJECT_DIR"
echo "🌐 Development server port: $DEV_PORT"
echo "🤖 MCP server port: $MCP_PORT"
echo ""

# Start MCP server in background
echo "Starting MCP server..."
(cd "$PROJECT_DIR" && cargo run --bin orbit-mcp -- --port "$MCP_PORT" --project "$PROJECT_DIR") &
MCP_PID=$!

# Give MCP server time to start
sleep 2

# Start development server
echo "Starting development server..."
(cd "$PROJECT_DIR" && cargo run --bin orbiton -- dev --port "$DEV_PORT" --dir "$PROJECT_DIR") &
DEV_PID=$!

# Function to handle termination
cleanup() {
    echo ""
    echo "Shutting down servers..."
    kill $MCP_PID $DEV_PID 2>/dev/null
    wait $MCP_PID $DEV_PID 2>/dev/null
    echo "Servers stopped"
    exit 0
}

# Set up signal handlers
trap cleanup INT TERM

# Wait for processes
wait $MCP_PID $DEV_PID
