#!/bin/bash

# Check if Brewfile exists
if [ ! -f "Brewfile" ]; then
    echo "Brewfile not found. Please ensure the Brewfile is in the current directory."
    exit 1
fi

# Install Homebrew if it's not installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    check_command_success
fi

# Install applications from Brewfile
echo "Installing applications from Brewfile..."
brew bundle --file=Brewfile

echo "Homebrew packages and casks installation completed successfully."
