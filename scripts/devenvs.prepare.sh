#!/bin/bash

# Check if asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "asdf is not installed. Please install asdf first."
    exit 1
fi

echo "Setting up development environments..."

# Ensure ASDF is initialized
source "$HOME/.asdf/asdf.sh"

# Install latest version of any toolchain
install_latest_version() {
    local language=$1
    echo "Installing latest version of $language..."
    asdf plugin-add $language || echo "$language plugin already added."
    asdf install $language latest
    asdf global $language latest
    echo "$language installation complete."
}

install_latest_version "python"
install_latest_version "rust"
install_latest_version "nodejs"

# Display installed versions
echo "Installed versions:"
asdf list python
asdf list rust
asdf list nodejs

echo "All toolchains installed successfully."