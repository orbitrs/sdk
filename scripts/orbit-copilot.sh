#!/bin/bash
# Orbit Framework common commands with GitHub Copilot CLI
# This script provides quick access to common Orbit Framework commands using GitHub Copilot CLI

set -e

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Check if GitHub Copilot CLI is installed
if ! gh extension list | grep -q copilot; then
    echo -e "${RED}GitHub Copilot CLI not found. Please install it first:${RESET}"
    echo "gh extension install github/gh-copilot"
    exit 1
fi

# Function to display help message
show_help() {
    echo -e "${BLUE}Orbit Framework - GitHub Copilot CLI Helper${RESET}"
    echo ""
    echo "Usage: $0 [category]"
    echo ""
    echo "Categories:"
    echo "  dev        - Development commands (default)"
    echo "  build      - Build commands"
    echo "  test       - Testing commands"
    echo "  lint       - Linting commands"
    echo "  git        - Git workflow commands"
    echo "  issue      - Create GitHub issues with Copilot"
    echo "  help       - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 dev     - Get suggestions for development commands"
    echo "  $0 build   - Get suggestions for build commands"
    echo "  $0 issue   - Get help creating issues with Copilot"
    echo ""
}

# Get suggestions based on category
get_suggestions() {
    local category=$1
    
    case "$category" in
        dev)
            echo -e "${GREEN}Development command suggestions:${RESET}"
            gh copilot suggest "Create a new Orbit component"
            ;;
        build)
            echo -e "${GREEN}Build command suggestions:${RESET}"
            gh copilot suggest "Build the Orbit Framework for production"
            ;;
        test)
            echo -e "${GREEN}Testing command suggestions:${RESET}"
            gh copilot suggest "Run tests for the orbit package"
            ;;
        lint)
            echo -e "${GREEN}Linting command suggestions:${RESET}"
            gh copilot suggest "Lint my Orbit components"
            ;;
        git)
            echo -e "${GREEN}Git workflow command suggestions:${RESET}"
            gh copilot suggest "Create a new branch for an Orbit feature"
            ;;
        issue)
            echo -e "${GREEN}Creating issues with GitHub Copilot:${RESET}"
            echo -e "${YELLOW}To create issues with GitHub Copilot:${RESET}"
            echo ""
            echo -e "1. Visit ${BLUE}https://github.com/copilot${RESET}"
            echo "2. In the 'Ask Copilot' box, try prompts like:"
            echo -e "   ${BLUE}Create a bug report for orbitrs/orbit about component lifecycle hooks not triggering${RESET}"
            echo -e "   ${BLUE}File a feature request for orlint to add support for custom linting rules${RESET}"
            echo ""
            echo "3. Copilot will draft an issue with title, description, and suggested labels"
            echo "4. Review, edit if needed, then click Create"
            echo ""
            echo -e "${YELLOW}You can also paste screenshots directly into the prompt for visual bugs${RESET}"
            echo ""
            echo -e "Would you like to open the GitHub Copilot page now? (y/n)"
            read -r response
            if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
                open "https://github.com/copilot" 2>/dev/null || xdg-open "https://github.com/copilot" 2>/dev/null || echo -e "${RED}Could not open browser automatically. Please visit https://github.com/copilot${RESET}"
            fi
            ;;
        *)
            echo -e "${YELLOW}Unknown category: $category${RESET}"
            show_help
            exit 1
            ;;
    esac
}

# Main script execution
if [ $# -eq 0 ]; then
    # No arguments, use default category
    get_suggestions "dev"
elif [ "$1" == "help" ]; then
    # Show help
    show_help
else
    # Use provided category
    get_suggestions "$1"
fi
