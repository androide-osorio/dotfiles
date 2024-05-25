#!/bin/bash

# Check for existing SSH keys
if [ -f "$HOME/.ssh/id_rsa" ] || [ -f "$HOME/.ssh/id_rsa.pub" ] || [ -f "$HOME/.ssh/id_ed25519" ] || [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
    echo "SSH keys already exist. Aborting."
    exit 1
fi

echo "Setting up SSH keys..."

# Generate a new SSH key using the ed25519 algorithm
read -p "Enter your email for SSH key generation: " email
read -s -p "Enter a passphrase(leave empty for no passphrase): " passphrase
echo

if [ -z "$passphrase" ]; then
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519" -N ""
else
    ssh-keygen -t ed25519 -C "$email" -f "$HOME/.ssh/id_ed25519" -N "$passphrase"
fi

# Start the SSH agent in the background
eval "$(ssh-agent -s)"

# Add the new SSH key to the SSH agent
echo "Adding SSH key to the SSH agent..."
ssh-add "$HOME/.ssh/id_ed25519"

# Check if gh CLI is authenticated
if ! gh auth status > /dev/null 2>&1; then
    echo "Logging into GitHub first..."
    gh auth login
fi

# Add the new SSH key to GitHub using gh cli
echo "Adding SSH key to GitHub..."
read -p "Enter a name for your new SSH key: " key_name
gh ssh-key add "$HOME/.ssh/id_ed25519.pub" -t "$key_name"

echo "Configured SSH keys successfully!"
