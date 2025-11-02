#!/bin/bash

# Check if asdf is installed
if ! command -v asdf &> /dev/null; then
    echo "asdf is not installed. Installing it now..."
    brew install asdf
    echo "asdf installation complete."
fi

echo "Setting up development environments..."

# Ensure ASDF is initialized
source "$HOME/.asdf/asdf.sh"

# Install latest version of any toolchain
install_latest_version() {
    local language=$1
    echo "Installing latest version of $language..."
    asdf plugin add $language || echo "$language plugin already added."
    asdf install $language latest
    asdf global $language latest
    echo "$language installation complete."
}

install_latest_version "python"
install_latest_version "uv"
install_latest_version "nodejs"
install_latest_version "pnpm"
install_latest_version "bun"

echo "Installing latest version of rust..."
# Install rust (with its own toolchain manager, better than asdf for this use case)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo "Rust installation complete."

# Display installed versions
echo "Installed versions:"
asdf list python
asdf list nodejs
asdf list pnpm
asdf list bun

echo "All toolchains installed successfully."
