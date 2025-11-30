#!/bin/bash

# Themes Setup Script
# This script downloads Catppuccin themes for bat and delta from their source repositories

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

print_status "Setting up Catppuccin themes for bat and delta..."

# Function to download a file
download_file() {
    local output_file="$1"
    local url="$2"

    if command_exists curl; then
        curl -L -f -s -o "$output_file" "$url"
    elif command_exists wget; then
        wget -q -O "$output_file" "$url"
    else
        print_error "Neither curl nor wget found. Please install one of them to download themes."
        exit 1
    fi
}

# Setup bat themes
BAT_THEMES_DIR=".config/bat/themes"
if [ ! -d "$BAT_THEMES_DIR" ]; then
    print_status "Creating bat themes directory: $BAT_THEMES_DIR"
    mkdir -p "$BAT_THEMES_DIR"
fi

BAT_THEMES=(
    "Catppuccin Latte"
    "Catppuccin Frappe"
    "Catppuccin Macchiato"
    "Catppuccin Mocha"
)

for theme in "${BAT_THEMES[@]}"; do
    theme_file="$BAT_THEMES_DIR/${theme}.tmTheme"
    # URL encode spaces as %20
    theme_url="https://github.com/catppuccin/bat/raw/main/themes/$(echo "$theme" | sed 's/ /%20/g').tmTheme"

    if [ -f "$theme_file" ]; then
        print_warning "Theme already exists: $theme_file (skipping)"
    else
        print_status "Downloading bat theme: $theme"
        if download_file "$theme_file" "$theme_url"; then
            print_success "Downloaded: $theme"
        else
            print_error "Failed to download: $theme"
            exit 1
        fi
    fi
done

# Setup delta theme
DELTA_DIR=".config/delta"
if [ ! -d "$DELTA_DIR" ]; then
    print_status "Creating delta directory: $DELTA_DIR"
    mkdir -p "$DELTA_DIR"
fi

DELTA_THEME_FILE="$DELTA_DIR/catppuccin.gitconfig"
DELTA_THEME_URL="https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig"

if [ -f "$DELTA_THEME_FILE" ]; then
    print_warning "Delta theme already exists: $DELTA_THEME_FILE (skipping)"
else
    print_status "Downloading delta theme..."
    if download_file "$DELTA_THEME_FILE" "$DELTA_THEME_URL"; then
        print_success "Downloaded delta catppuccin theme"
    else
        print_error "Failed to download delta theme"
        exit 1
    fi
fi

print_success "Themes setup completed!"
