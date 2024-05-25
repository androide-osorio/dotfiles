# Dotfiles

This repository consists of configuration for any tools I use to cinfigure my development environment in new machines.

## Installation

> These are my terminal and program configurations for MacOS. It is tweaked for my own preferences!.

Firstly, clone this repository down to `~/.dotfiles`.

```bash
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
```

Next, install Homebrew in the new MacOS machine:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install all programs and Casks by running:

```bash
brew bundle
```

Configure additional tools and development environments with the included custom scripts

```bash
./scripts/prepare-vim.sh
./scripts/prepare-envs.sh
```

## Author

Andrés Osorio | [@androide-osorio](https://github.com/androide-osorio)
