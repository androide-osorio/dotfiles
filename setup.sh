#!/bin/bash

# Function to check the result of the previous command and exit if it failed
check_command_success() {
    if [ $? -ne 0 ]; then
        echo "An error occurred. Exiting."
        exit 1
    fi
}

# Install applications from Brewfile
./scripts/brew.prepare.sh
check_command_success

# Execute SSH setup script
./scripts/ssh.prepare.sh
check_command_success

# Execute development environments setup script
./scripts/devenvs.prepare.sh
check_command_success

# Execute Vim/Neovim setup script
./scripts/vim.prepare.sh
check_command_success

# Sync stow files
stow . --target=$HOME

echo "Setup completed successfully."