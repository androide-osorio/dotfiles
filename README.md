# Dotfiles

A modern, automated development environment setup for macOS using GNU Stow for configuration management. This repository provides a complete development environment with Fish shell, Neovim, Tmux, and modern CLI tools.

## Features

- **🐟 Fish Shell**: Modern shell with advanced features and vi key bindings
- **📝 Neovim**: Configured with NvChad for a modern Vim experience
- **🖥️ Tmux**: Terminal multiplexer with custom key bindings
- **⭐ Starship**: Beautiful cross-shell prompt
- **🔍 fzf**: Fuzzy finder with Git integration
- **🛠️ Modern CLI Tools**: bat, lsd, ripgrep, zoxide, and more
- **🐍 Development Environments**: Python, Rust, Node.js via asdf
- **🔐 SSH Setup**: Automated SSH key generation and GitHub integration
- **🔒 Environment Variables**: Secure API key management with template system
- **📦 Package Management**: Homebrew with comprehensive package list

## Quick Start

> ⚠️ **Warning**: This will modify your shell configuration and install many packages. Consider backing up your current setup first.

### Automated Installation (Recommended)

```bash
# Clone and setup everything automatically
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
chmod +x setup.sh
./setup.sh
```

This single command will:

1. Install Homebrew (if not present)
2. Install all packages and GUI applications
3. Set up SSH keys interactively
4. Install Python, Rust, and Node.js via asdf
5. Install Neovim with NvChad configuration
6. Set up secure environment variable management
7. Symlink all configuration files to your home directory

### Manual Installation

If you prefer to run steps individually:

```bash
# Clone the repository
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install Homebrew packages and GUI applications
./scripts/brew.prepare.sh

# Set up SSH keys (interactive - requires email and passphrase)
./scripts/ssh.prepare.sh

# Install development environments (Python, Rust, Node.js)
./scripts/devenvs.prepare.sh

# Install Neovim with NvChad configuration
./scripts/vim.prepare.sh

# Set up secure environment variable management
./scripts/env.prepare.sh

# Symlink all configuration files to home directory
stow . --target=$HOME
```

## What You'll Get

After installation, you'll have a complete development environment including:

### Shell & Terminal

- **Fish shell** with vi key bindings and modern features
- **Starship prompt** for beautiful terminal experience
- **fzf** for fuzzy finding with Git integration
- **zoxide** for smart directory navigation

### Development Tools

- **Neovim** with NvChad configuration
- **Tmux** for terminal multiplexing
- **Git** with SSH signing and 1Password integration
- **asdf** for managing Python, Rust, and Node.js versions

### CLI Tools

- **bat** (better cat with syntax highlighting)
- **lsd** (better ls with icons and colors)
- **ripgrep** (fast text search)
- **gh** (GitHub CLI)
- **jq** (JSON processing)

### GUI Applications

- Arc browser, VS Code, Docker, Figma, Obsidian, and more

### Security Features

- **Secure Environment Variables**: Template-based API key management
- **SSH Key Management**: Automated generation with GitHub integration
- **Git Signing**: SSH-based commit signing with 1Password integration

## Customization

After installation, you can customize your environment:

```bash
# Switch to Fish shell as default
chsh -s /opt/homebrew/bin/fish

# Edit Fish configuration (modular architecture)
nvim ~/.config/fish/config.fish          # Main orchestrator
nvim ~/.config/fish/env/env.fish         # Environment variables
nvim ~/.config/fish/env/aliases.fish     # Command aliases
nvim ~/.config/fish/env/path.fish        # PATH management
nvim ~/.config/fish/env/secrets.fish     # API keys and secrets

# Edit Neovim configuration
nvim ~/.config/nvim/lua/chadrc.lua

# Edit Tmux configuration
nvim ~/.config/tmux/tmux.conf
```

### Fish Configuration Architecture

The Fish shell configuration uses a **modular architecture** for better maintainability:

```
.config/fish/
├── config.fish              # Main orchestrator file
├── env/                     # Environment configurations
│   ├── env.fish            # Core environment variables
│   ├── path.fish           # PATH management
│   ├── aliases.fish        # Command aliases
│   ├── secrets.fish        # Sensitive data (gitignored)
│   └── secrets.tpl.fish    # Template for secrets
├── custom/                  # Custom integrations
│   ├── completions.fish    # Command completions
│   ├── setup_fzf.fish      # FZF configuration
│   └── git_fzf.fish        # Git+FZF integration
├── functions/               # Command overrides
│   ├── cat.fish            # bat wrapper
│   ├── ls.fish             # lsd wrapper
│   └── tree.fish           # lsd tree wrapper
└── conf.d/                  # Fish auto-loading
    └── asdf.fish           # ASDF integration
```

**Benefits of this architecture**:
- **Separation of Concerns**: Each file has a single responsibility
- **Easy Maintenance**: Find and modify specific functionality quickly
- **Security**: Secrets are isolated and templated
- **Modularity**: Add new features without cluttering main config

## Important Notes

- **SSH Setup**: The SSH script will generate new keys - you may want to use existing ones
- **Environment Variables**: After setup, edit `~/.config/fish/env/secrets.fish` to add your API keys and secrets
- **Terminal Choice**: Ghostty terminal emulator
- **macOS Only**: This setup is designed specifically for macOS (ARM64 and Intel)

## Environment Variable Management

This dotfiles setup includes a secure environment variable management system that prevents accidental commits of API keys and secrets.

### How It Works

1. **Template System**: A `secrets.tpl.fish` template file is committed to the repository
2. **Local Configuration**: The setup script creates a local `secrets.fish` file from the template
3. **Git Protection**: The actual `secrets.fish` file is gitignored to prevent accidental commits
4. **Stow Integration**: Environment files are managed through Stow like other configurations

### Setting Up Your Environment Variables

After running the setup script, you'll need to configure your environment variables:

```bash
# Edit your environment variables
nvim ~/.config/fish/env/secrets.fish

# Sync changes to your home directory
stow . --target=$HOME
```

### Example Environment Variables

```fish
# OpenAI API Key (recommended: use 1Password CLI)
set -gx MY_KEY (op read "op://Path/To/API_Key")

# Direct API key (less secure)
# set -gx MY_KEY "your-actual-api-key-here"

# Other common environment variables
set -gx GITHUB_TOKEN (op read "op://Personal/GitHub/Personal Access Token")
set -gx AWS_ACCESS_KEY_ID (op read "op://Personal/AWS/Access Key ID")
```

### Security Benefits

- ✅ **No Accidental Commits**: Environment files are gitignored
- ✅ **Template Safety**: Only safe examples are committed
- ✅ **1Password Integration**: Supports secure key management
- ✅ **Cross-Machine Consistency**: Same structure on all machines

## Uninstalling

```bash
# Remove all configurations
cd ~/.dotfiles
stow . --target=$HOME --delete

# Remove Homebrew packages (optional)
brew bundle cleanup --file=Brewfile
```

## Author

Andrés Osorio | [@androide-osorio](https://github.com/androide-osorio)
