#!/bin/bash

# Environment Variables Setup Script
# This script sets up the environment variables template for Fish shell

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if we're in the right directory
if [ ! -f "setup.sh" ]; then
    print_error "This script must be run from the dotfiles root directory"
    exit 1
fi

print_status "Setting up environment variables configuration..."

# Create the env directory in dotfiles repo if it doesn't exist
ENV_DIR=".config/fish/env"
if [ ! -d "$ENV_DIR" ]; then
    print_status "Creating environment directory: $ENV_DIR"
    mkdir -p "$ENV_DIR"
fi

# Check if secrets.fish already exists in dotfiles repo
ENV_FILE="$ENV_DIR/secrets.fish"
TEMPLATE_FILE="$ENV_DIR/secrets.tpl.fish"

if [ -f "$ENV_FILE" ]; then
    print_warning "Environment file already exists: $ENV_FILE"
    print_warning "Skipping template copy to avoid overwriting existing configuration"
else
    if [ -f "$TEMPLATE_FILE" ]; then
        print_status "Copying environment template to $ENV_FILE"
        cp "$TEMPLATE_FILE" "$ENV_FILE"
        print_success "Environment template copied successfully"
        print_warning "Please edit $ENV_FILE and add your actual API keys and secrets"
        print_status "After editing, run 'stow . --target=$HOME' to sync to your home directory"
    else
        print_error "Template file not found: $TEMPLATE_FILE"
        print_error "Make sure you're running this from the dotfiles directory"
        exit 1
    fi
fi

# Check if 1Password CLI is available
if command_exists op; then
    print_status "1Password CLI detected - you can use 'op read' commands in your secrets.fish"
    print_status "Example: set -gx MY_KEY (op read \"op://Vault/My Key\")"
else
    print_warning "1Password CLI not found - you'll need to use direct API keys in secrets.fish"
    print_warning "Install 1Password CLI for more secure key management: brew install 1password-cli"
fi

print_success "Environment variables setup completed!"
print_status "Next steps:"
print_status "1. Edit $ENV_FILE with your actual API keys"
print_status "2. Run 'stow . --target=$HOME' to sync the environment file to your home directory"
print_status "3. Restart your Fish shell or run: source ~/.config/fish/config.fish"
print_status "4. Test your environment variables with: echo \$MY_KEY"