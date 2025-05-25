#!/bin/bash
# Setup script for GitHub Copilot CLI integration with Orbit Framework
# This script helps set up GitHub Copilot CLI for use with the Orbit Framework

set -e

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "${BLUE}===========================================================${RESET}"
echo -e "${BLUE}    Setting up GitHub Copilot CLI for Orbit Framework    ${RESET}"
echo -e "${BLUE}===========================================================${RESET}"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &>/dev/null; then
    echo -e "${YELLOW}GitHub CLI (gh) not found. Installing...${RESET}"
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &>/dev/null; then
            brew install gh
        else
            echo -e "${RED}Homebrew not found. Please install Homebrew first:${RESET}"
            echo "https://brew.sh/"
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo -e "${YELLOW}Installing GitHub CLI on Linux...${RESET}"
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt update
        sudo apt install gh -y
    else
        echo -e "${RED}Unsupported OS. Please install GitHub CLI manually:${RESET}"
        echo "https://github.com/cli/cli#installation"
        exit 1
    fi
else
    echo -e "${GREEN}✓ GitHub CLI already installed${RESET}"
fi

# Check if logged in to GitHub
if ! gh auth status &>/dev/null; then
    echo -e "${YELLOW}You need to login to GitHub CLI${RESET}"
    gh auth login
else
    echo -e "${GREEN}✓ Already authenticated with GitHub CLI${RESET}"
fi

# Check if gh copilot extension is installed
if ! gh extension list | grep -q "gh-copilot"; then
    echo -e "${YELLOW}Installing GitHub Copilot CLI extension...${RESET}"
    gh extension install github/gh-copilot
else
    echo -e "${GREEN}✓ GitHub Copilot CLI extension already installed${RESET}"
fi

# Setup shell aliases
SHELL_CONFIG=""
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_CONFIG=~/.zshrc
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_CONFIG=~/.bashrc
fi

if [[ -n "$SHELL_CONFIG" ]]; then
    echo -e "${YELLOW}Setting up shell aliases in $SHELL_CONFIG...${RESET}"
    
    # Check if aliases already exist
    if ! grep -q "# Orbit Framework Copilot CLI aliases" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# Orbit Framework Copilot CLI aliases" >> "$SHELL_CONFIG"
        echo "alias '??'='gh copilot explain'" >> "$SHELL_CONFIG"
        echo "alias ghcs='gh copilot suggest'" >> "$SHELL_CONFIG"
        echo -e "${GREEN}✓ Aliases added to $SHELL_CONFIG${RESET}"
        echo -e "${YELLOW}Please run 'source $SHELL_CONFIG' to apply changes${RESET}"
    else
        echo -e "${GREEN}✓ Aliases already set up in $SHELL_CONFIG${RESET}"
    fi
else
    echo -e "${YELLOW}Could not determine shell configuration file.${RESET}"
    echo -e "${YELLOW}To add aliases manually, add these lines to your shell config:${RESET}"
    echo "alias '??'='gh copilot explain'"
    echo "alias ghcs='gh copilot suggest'"
fi

echo ""
echo -e "${GREEN}===========================================================${RESET}"
echo -e "${GREEN}    GitHub Copilot CLI setup complete!    ${RESET}"
echo -e "${GREEN}===========================================================${RESET}"
echo ""
echo -e "You can now use GitHub Copilot CLI with these commands:"
echo -e "  ${BLUE}gh copilot explain${RESET} - Get explanation for a command"
echo -e "  ${BLUE}gh copilot suggest${RESET} - Get command suggestions"
echo ""
echo -e "Or with the aliases (after reloading your shell):"
echo -e "  ${BLUE}??${RESET} - Get explanation for a command"
echo -e "  ${BLUE}ghcs${RESET} - Get command suggestions"
echo ""
echo -e "For more information, see:"
echo -e "${BLUE}docs/tooling/github-copilot-cli.md${RESET}"
echo ""
