#!/bin/bash

# This script sets Fish shell as the default shell for macOS

check_command_success() {
    if [ $? -ne 0 ]; then
        echo "An error occurred. Exiting."
        exit 1
    fi
}

# Find Fish shell binary path (handles both ARM64 and Intel Macs)
FISH_PATH=""

# Check common Homebrew paths for Fish
if [ -f "/opt/homebrew/bin/fish" ]; then
    # ARM64 Mac (Apple Silicon)
    FISH_PATH="/opt/homebrew/bin/fish"
elif [ -f "/usr/local/bin/fish" ]; then
    # Intel Mac
    FISH_PATH="/usr/local/bin/fish"
else
    # Try using which/command to find Fish
    FISH_PATH=$(command -v fish)
fi

# Check if Fish is installed
if [ -z "$FISH_PATH" ] || [ ! -f "$FISH_PATH" ]; then
    echo "Error: Fish shell is not installed."
    echo "Please ensure Fish is installed via Homebrew before running this script."
    exit 1
fi

echo "Found Fish shell at: $FISH_PATH"

# Check current default shell
CURRENT_SHELL=$(dscl . -read /Users/$USER UserShell | awk '{print $2}')

if [ "$CURRENT_SHELL" = "$FISH_PATH" ]; then
    echo "Fish shell is already set as the default shell."
    exit 0
fi

echo "Current default shell: $CURRENT_SHELL"
echo "Setting Fish shell as the default shell..."

# Use chsh to change the default shell
# Note: This will prompt for the user's password on macOS
chsh -s "$FISH_PATH"
check_command_success

echo "Fish shell has been set as the default shell."
echo "Note: The change will take effect on your next login or after restarting your terminal."
