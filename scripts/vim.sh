#!/usr/bin/env bash

# Remove old nvim config if it exists
rm -rf ~/.config/nvim

# Install NVchad
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1 && nvim
