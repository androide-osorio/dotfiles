# AGENTS.md - LLM Agent Configuration Guide

This document provides comprehensive information for LLM agents working with this dotfiles repository. This is a sophisticated, production-grade development environment setup using modern tooling and best practices.

## Repository Overview

**Owner**: Andrés Osorio (@androide-osorio)
**Purpose**: Automated development environment setup for macOS machines
**Architecture**: Layered installation with GNU Stow for configuration management
**Target Platform**: macOS (ARM64/Intel compatible)

## Core Architecture

### 1. GNU Stow Configuration Management

- **Primary Tool**: GNU Stow for symlink-based dotfile management
- **Command**: `stow . --target=$HOME` (executed in `setup.sh`)
- **Structure**: Maintains directory hierarchy through symlinks
- **Benefits**: Easy installation/uninstallation, no file conflicts, clean separation

### 2. Layered Installation Strategy

The setup follows a 5-layer approach with independent failure handling:

1. **Package Management** (`scripts/brew.prepare.sh`)
2. **Security Setup** (`scripts/ssh.prepare.sh`)
3. **Development Environments** (`scripts/devenvs.prepare.sh`)
4. **Editor Configuration** (`scripts/vim.prepare.sh`)
5. **Environment Variables** (`scripts/env.prepare.sh`)

### 3. Stow Ignore Configuration

File: `.stow-local-ignore`

```txt
# OS files
.DS_Store

# ignore git files
\.git
\.gitignore
\.gitmodules

# script files are utility shell scripts. Do not sync
^/scripts

^/README.*
Brewfile
Brewfile.lock.json
setup.sh

# Environment files with secrets - do not sync
^/\.config/fish/env/secrets\.fish$
```

## Package Management (Homebrew)

### Brewfile Structure

- **Taps**: homebrew/bundle, homebrew/core, homebrew/cask, homebrew/cask-versions, homebrew/cask-fonts
- **Categories**: Basic tools, packages, casks (GUI apps), fonts
- **Key Tools**: asdf, fish, neovim, tmux, starship, stow, fzf, bat, lsd, ripgrep

### Critical Dependencies

- **asdf**: Universal version manager for multiple languages
- **fish**: Modern shell with advanced features
- **neovim**: Primary editor with NvChad configuration
- **stow**: Dotfile management system
- **starship**: Cross-shell prompt
- **fzf**: Fuzzy finder with extensive integrations

## Shell Configuration (Fish)

### Modular Architecture Overview

The Fish shell configuration uses a **sophisticated modular architecture** that separates concerns and provides excellent maintainability. This represents a significant evolution from monolithic configuration files.

### Directory Structure

```
.config/fish/
├── config.fish              # Main orchestrator file (clean, minimal)
├── env/                     # Environment-specific configurations
│   ├── env.fish            # Core environment variables
│   ├── path.fish           # PATH management with fish_add_path
│   ├── aliases.fish        # Command aliases
│   ├── secrets.fish        # Sensitive data (gitignored)
│   └── secrets.tpl.fish    # Template for secrets
├── custom/                  # Custom integrations and workflows
│   ├── completions.fish    # Command completions (1Password CLI)
│   ├── setup_fzf.fish      # FZF configuration and integration
│   └── git_fzf.fish        # Advanced Git+FZF workflow
├── functions/               # Command overrides and wrappers
│   ├── cat.fish            # bat wrapper for syntax highlighting
│   ├── ls.fish             # lsd wrapper with directory grouping
│   └── tree.fish           # lsd tree wrapper
└── conf.d/                  # Fish auto-loading directory
    └── asdf.fish           # ASDF integration
```

### Main Orchestrator

File: `.config/fish/config.fish`

**Architecture**: Acts as a clean orchestrator that loads modular components in logical order:

```fish
set fish_greeting

# Key bindings
fish_vi_key_bindings

# Environment variables
source $HOME/.config/fish/env/env.fish

# Load environment variables from secrets.fish if it exists
if test -f $HOME/.config/fish/env/secrets.fish
  source $HOME/.config/fish/env/secrets.fish
end

# Setup system paths
source $HOME/.config/fish/env/path.fish

# Load aliases
source $HOME/.config/fish/env/aliases.fish

# Load completions
source $HOME/.config/fish/custom/completions.fish

# Set up fzf
source $HOME/.config/fish/custom/setup_fzf.fish

# zoxide setup
zoxide init --cmd cd fish | source

# initialize starship
starship init fish --print-full-init | sed 's/"$(commandline)"/(commandline | string collect)/' | source
```

**Key Design Principles**:

- **Single Responsibility**: Each sourced file has one clear purpose
- **Conditional Loading**: Safe loading of optional components
- **Logical Order**: Environment → Paths → Aliases → Integrations → Tools

### Environment Configuration (`env/`)

#### Core Environment Variables

File: `.config/fish/env/env.fish`

```fish
# Add custom environment variables to the machine's environment.
# Mostly used for custom variables and some global settings
# like the default terminal editor, etc.
set -gx BAT_THEME 'OneHalfDark'
set -gx DOTFILES "$HOME/.dotfiles"
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -gx LANG en_US.UTF-8
set -Ux XDG_CONFIG_HOME $HOME/.config
```

#### PATH Management

File: `.config/fish/env/path.fish`

```fish
# Add custom paths to the PATH environment variable
fish_add_path (brew --prefix)/bin
fish_add_path $HOME/.cargo/bin
fish_add_path -a $HOME/.lmstudio/bin
```

**Benefits**:

- Uses `fish_add_path` for clean PATH management
- Prevents duplicate entries
- Maintains proper PATH order

#### Command Aliases

File: `.config/fish/env/aliases.fish`

```fish
# Fish Shell Aliases
# This file contains all command aliases for the Fish shell

# Directory navigation
alias . 'pwd'

# File listing
alias ll 'ls -la'

# Editor aliases
alias vim 'nvim'
alias vi 'nvim'

# Add your custom aliases here
# Example:
# alias g 'git'
# alias ga 'git add'
# alias gc 'git commit'
# alias gp 'git push'
# alias gs 'git status'
```

**Design**: Clean, documented aliases with examples for common Git workflows.

### Custom Integrations (`custom/`)

#### FZF Configuration

File: `.config/fish/custom/setup_fzf.fish`

```fish
# Setup FZF integration with custom options
# and Git fzf integration
set -gx FZF_DEFAULT_OPTS "--reverse --border double --height 80% --cycle --wrap"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range=:500 --style=numbers {}' --preview-window right:60%:wrap"
set -gx FZF_ALT_C_OPTS "--preview 'lsd --group-dirs=first --color=always --tree {} | head -200'"

if status is-interactive && test -f ./git_fzf.fish
  source ./git_fzf.fish
  git_fzf_key_bindings
end

fzf --fish | source
```

**Features**:

- Custom preview windows with `bat` and `lsd`
- Conditional Git integration loading
- Interactive-only loading for performance

#### Command Completions

File: `.config/fish/custom/completions.fish`

```fish
# Command line completions for various commands
# I regularly use.

# 1Password CLI
op completion fish | source
```

**Extensible**: Easy to add new command completions as needed.

#### Git+FZF Integration

File: `.config/fish/custom/git_fzf.fish`

- Comprehensive git+fzf integration
- Key bindings: `Ctrl+g Ctrl+f` (status), `Ctrl+g Ctrl+b` (branches), etc.
- Multi-selection support for git operations
- Preview windows for git history and diffs

### Function Overrides (`functions/`)

#### Command Wrappers

**cat.fish**:

```fish
function cat --wraps=bat --description 'alias cat=bat'
  bat $argv;
end
```

**ls.fish**:

```fish
function ls --wraps='lsd --group-dirs first' --wraps='lsd --group-dirs=first' --description 'alias ls=lsd --group-dirs=first'
  lsd --group-dirs=first $argv;
end
```

**tree.fish**:

```fish
function tree --wraps='lsd --tree' --description 'alias tree=lsd --tree'
  lsd --tree $argv;
end
```

**Design Patterns**:

- **Wrapper Pattern**: Maintains command compatibility while enhancing functionality
- **Proper Metadata**: Uses `--wraps` and `--description` for Fish integration
- **Argument Forwarding**: Preserves all command arguments with `$argv`

### Auto-Loading Configuration (`conf.d/`)

#### ASDF Integration

File: `.config/fish/conf.d/asdf.fish`

```fish
# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
```

**Benefits**:
- Auto-loads with Fish shell
- Proper PATH management for ASDF shims
- Clean variable cleanup

### Architecture Benefits

1. **Separation of Concerns**: Each file has a single, clear responsibility
2. **Maintainability**: Easy to find, modify, and extend specific functionality
3. **Security**: Secrets are properly isolated and templated
4. **Performance**: Conditional loading and lazy initialization
5. **Collaboration**: Multiple people can work on different aspects without conflicts
6. **Documentation**: Each file is self-documenting with clear purposes
7. **Testing**: Individual components can be tested separately
8. **Version Control**: Changes are isolated to specific files, reducing merge conflicts

### Design Patterns Used

1. **Template Pattern**: `secrets.tpl.fish` → `secrets.fish` prevents accidental secret commits
2. **Wrapper Pattern**: Function overrides maintain command compatibility while enhancing functionality
3. **Modular Loading**: Each component loads independently, making debugging easier
4. **Conditional Loading**: Safe loading of optional components (secrets, git_fzf)
5. **Orchestrator Pattern**: Main config file coordinates loading of all modules

## Terminal Configuration

### Ghostty Terminal

File: `.config/ghostty/config`

- **Theme**: Catppuccin Frappe
- **Font**: JetBrainsMono Nerd Font Mono (16pt)
- **Shell**: Fish shell integration
- **Features**: Background blur, quick terminal, custom keybindings
- **Window**: 135x40 default size with padding

### Alacritty Configuration

File: `.config/alacritty/alacritty.toml`

- **Theme**: Catppuccin Macchiato (imported)
- **Font**: JetBrainsMono Nerd Font Mono (16pt)
- **Startup**: Simple fullscreen mode
- **Keybindings**: Cmd+Enter for fullscreen toggle

## Tmux Configuration

File: `.config/tmux/tmux.conf`

**Key Bindings**:

- Prefix: `Ctrl+a` (remapped from `Ctrl+b`)
- Split: `|` (horizontal), `-` (vertical)
- Pane switching: `Alt+Arrow` (no prefix required)
- Reload config: `r`

**Design**:

- Mouse control enabled
- Base index starts at 1 (not 0)
- Custom status bar with color coding
- Window renaming disabled

## Git Configuration

File: `.gitconfig`

**Advanced Features**:

- SSH-based commit signing with 1Password integration
- Comprehensive aliases for common operations
- Git LFS configuration
- Custom branch formatting

**Key Aliases**:

- `a` → `add`
- `st` → `status`
- `cm` → `commit -m`
- `amendit` → `commit --amend --no-edit`
- `br` → formatted branch list
- `lg` → graph log with colors

## Development Environment Setup

### asdf Configuration

File: `scripts/devenvs.prepare.sh`

- **Languages**: Python, Rust, Node.js
- **Strategy**: Install latest versions automatically
- **Global**: Sets latest as global version for each language

### Neovim Configuration

File: `scripts/vim.prepare.sh`

- **Distribution**: NvChad (modern Neovim configuration)
- **Installation**: Git clone with depth 1 for minimal download
- **Configuration**: Located in `.config/nvim/lua/chadrc.lua`

**NvChad Settings**:

- Theme: Palenight
- Italic comments enabled
- Custom statusline and tabufline
- Lazy loading enabled

## SSH Configuration

File: `scripts/ssh.prepare.sh`

- **Algorithm**: ed25519 (modern, secure)
- **Integration**: GitHub CLI for automatic key upload
- **Agent**: SSH agent management
- **Validation**: Checks for existing keys before generation

## Environment Variable Management

### Secure API Key Management System

File: `scripts/env.prepare.sh`

**Architecture**:

- **Template System**: `.config/fish/env/secrets.tpl.fish` (committed to repo)
- **Local Configuration**: `.config/fish/env/secrets.fish` (gitignored, created from template)
- **Stow Integration**: Environment files managed through Stow like other configs
- **Runtime Loading**: Fish config safely sources environment file if it exists

**Security Features**:

- **Git Protection**: Actual `secrets.fish` file is gitignored via `.stow-local-ignore`
- **Template Safety**: Only safe examples and comments are committed
- **1Password Integration**: Supports `op read` commands for secure key management
- **Cross-Machine Consistency**: Same environment structure on all machines

**File Structure**:

```bash
.config/fish/env/
├── secrets.tpl.fish    # Template (committed to repo)
└── secrets.fish        # Local config (gitignored, created from template)
```

**Template Content** (`secrets.tpl.fish`):

```bash
# Environment Variables Template
# Copy this file to secrets.fish and fill in your actual values
# This file is gitignored to prevent accidental commits of secrets

# Option 1: Direct key (less secure)
# set -gx MY_KEY "your-actual-api-key-here"

# Option 2: 1Password reference (recommended)
# set -gx MY_KEY (op read "op://Path/To/API_KEY")

# Add other sensitive environment variables here
# set -gx ANOTHER_API_KEY "your-key-here"
# set -gx DATABASE_URL "your-database-url-here"
```

**Setup Process**:

1. `env.prepare.sh` creates `secrets.fish` from template
2. User edits `secrets.fish` with actual API keys/secrets
3. `stow . --target=$HOME` syncs environment file to home directory
4. Fish shell loads environment variables at startup

**Benefits**:

- **Zero Secret Exposure**: No API keys or secrets in git history
- **Automated Setup**: New machines get environment structure automatically
- **Flexible Configuration**: Supports both direct keys and 1Password CLI
- **Version Control**: Template changes are tracked, secrets are not

## Starship Prompt

File: `.config/starship.toml`

- **Schema**: Uses official schema reference
- **Integration**: Initialized in Fish shell with commandline compatibility fix

## Installation Scripts

### Main Setup Script

File: `setup.sh`

- **Error Handling**: `check_command_success()` function
- **Order**: brew → ssh → devenvs → vim → env → stow
- **Validation**: Each step validates before proceeding

### Individual Scripts

All scripts include:

- Error checking and validation
- User-friendly output messages
- Graceful failure handling
- Dependency verification

## File Structure

```bash
.dotfiles/
├── .config/
│   ├── alacritty/          # Terminal emulator config
│   ├── fish/               # Fish shell configuration (modular architecture)
│   │   ├── config.fish     # Main orchestrator file
│   │   ├── conf.d/         # Fish auto-loading directory
│   │   │   └── asdf.fish   # ASDF integration
│   │   ├── custom/         # Custom integrations and workflows
│   │   │   ├── completions.fish    # Command completions
│   │   │   ├── setup_fzf.fish      # FZF configuration
│   │   │   └── git_fzf.fish        # Git+FZF integration
│   │   ├── env/            # Environment variable management
│   │   │   ├── env.fish            # Core environment variables
│   │   │   ├── path.fish            # PATH management
│   │   │   ├── aliases.fish        # Command aliases
│   │   │   ├── secrets.tpl.fish    # Template (committed)
│   │   │   └── secrets.fish        # Local config (gitignored)
│   │   └── functions/      # Command overrides and wrappers
│   │       ├── cat.fish            # bat wrapper
│   │       ├── ls.fish             # lsd wrapper
│   │       └── tree.fish           # lsd tree wrapper
│   ├── ghostty/            # Ghostty terminal config
│   ├── nvim/               # Neovim configuration
│   ├── starship.toml       # Prompt configuration
│   └── tmux/               # Tmux configuration
├── .ssh/                   # SSH configuration (if exists)
├── scripts/                # Installation automation scripts
├── Brewfile                # Homebrew package definitions
├── setup.sh               # Main installation orchestrator
├── .gitconfig             # Git configuration
├── .tmux.conf             # Tmux symlink target
└── .stow-local-ignore     # Stow ignore patterns
```

## Repository Consumer Guide

### For End Users (Using These Dotfiles)

This section is for developers who want to use these dotfiles on their own macOS machines.

#### Prerequisites

- macOS (ARM64 or Intel)
- Internet connection for downloading packages
- GitHub account (for SSH key setup)

#### Quick Start (Recommended)

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

#### What You'll Get

After installation, you'll have:

- **Fish shell** as your default shell with modern features
- **Neovim** with NvChad (a modern Vim configuration)
- **Tmux** for terminal multiplexing
- **fzf** for fuzzy finding with Git integration
- **Starship** prompt for a beautiful terminal
- **Modern CLI tools**: bat, lsd, ripgrep, zoxide
- **Development environments**: Python, Rust, Node.js
- **GUI applications**: Arc browser, VS Code, Docker, etc.

#### Customization After Installation

```bash
# Switch to Fish shell
chsh -s /opt/homebrew/bin/fish

# Edit Fish configuration
nvim ~/.config/fish/config.fish

# Edit Neovim configuration
nvim ~/.config/nvim/lua/chadrc.lua

# Edit Tmux configuration
nvim ~/.config/tmux/tmux.conf
```

#### Important Notes for Consumers

- **Backup first**: This will modify your shell configuration and install many packages
- **SSH setup**: The SSH script will generate new keys - you may want to use existing ones
- **Environment Variables**: After setup, edit `~/.config/fish/env/secrets.fish` to add your API keys and secrets
- **Terminal choice**: Both Ghostty and Alacritty configs exist - choose your preferred terminal

#### Uninstalling (If Needed)

```bash
# Remove all configurations
cd ~/.dotfiles
stow . --target=$HOME --delete

# Remove Homebrew packages (optional)
brew bundle cleanup --file=Brewfile
```

## Usage Commands

### Initial Setup (New Machine)

```bash
# 1. Clone the repository
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 2. Make setup script executable and run
chmod +x setup.sh
./setup.sh
```

### Manual Installation Steps

If you prefer to run steps individually:

```bash
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

### Updating Existing Installation

```bash
# Update Homebrew packages
brew bundle --file=Brewfile

# Update asdf language versions
asdf update
asdf install python latest
asdf install rust latest
asdf install nodejs latest

# Update Neovim configuration
cd ~/.config/nvim && git pull

# Re-symlink configurations (if you've made changes)
cd ~/.dotfiles
stow . --target=$HOME --restow
```

### Testing Installation

```bash
# Test that all key tools are installed
which fish neovim tmux starship fzf bat lsd

# Test Fish configuration
fish -c "echo 'Fish shell working'"

# Test Git configuration
git config --list | grep -E "(user|gpg|commit)"

# Test Stow symlinks
ls -la ~/.config/fish/config.fish
ls -la ~/.tmux.conf
ls -la ~/.gitconfig
```

### Uninstalling

```bash
# Remove all symlinked configurations
cd ~/.dotfiles
stow . --target=$HOME --delete

# Remove Homebrew packages (optional - keeps GUI apps)
brew bundle cleanup --file=Brewfile

# Remove development environments (optional)
asdf uninstall python latest
asdf uninstall rust latest
asdf uninstall nodejs latest
```

### Troubleshooting Commands

```bash
# Check Stow status
stow . --target=$HOME --simulate

# Verify Fish functions are loaded
fish -c "functions | grep -E '(cat|ls|tree)'"

# Test fzf integration
fish -c "fzf --version"

# Check Git signing
git config --get commit.gpgsign
git config --get gpg.format

# Validate SSH setup
ssh-add -l
gh auth status
```

## Agent Guidelines

### When Modifying This Repository

1. **Respect the Stow Structure**: All configuration files should be in their proper `.config/` subdirectories
2. **Update Scripts Carefully**: Installation scripts have error handling - maintain this pattern
3. **Test Layer Independence**: Each installation layer should work independently
4. **Maintain Compatibility**: Changes should work on both ARM64 and Intel macOS
5. **Document Changes**: Update this file when adding new tools or configurations

### Common Modifications

**Adding New Tools**:

1. Add to `Brewfile` (package) or `Brewfile` casks (GUI app)
2. Add configuration to appropriate `.config/` subdirectory
3. Update installation scripts if needed
4. Test with `stow . --target=$HOME`

**Modifying Shell Configuration**:

1. **Environment Variables**: Edit `.config/fish/env/env.fish` for core variables
2. **PATH Management**: Edit `.config/fish/env/path.fish` for PATH modifications
3. **Aliases**: Edit `.config/fish/env/aliases.fish` for command aliases
4. **Functions**: Add functions to `.config/fish/functions/` for command overrides
5. **Custom Integrations**: Add integrations to `.config/fish/custom/`
6. **Completions**: Add completions to `.config/fish/custom/completions.fish`
7. **Main Config**: Edit `.config/fish/config.fish` only for orchestration changes
8. Test Fish configuration with `fish -c "source ~/.config/fish/config.fish"`

**Adding Terminal Themes**:

1. Add theme files to `.config/alacritty/` or `.config/ghostty/`
2. Update import statements in main config files
3. Test theme switching

### Security Considerations

- **Environment Variables**: Secure API key management system prevents accidental commits of secrets
- **SSH Keys**: SSH setup script generates keys interactively - maintain this security practice
- **Git Signing**: Uses 1Password integration for SSH-based commit signing
- **Template System**: Environment variable templates provide safe examples without exposing real secrets

### Performance Notes

- **Fish Shell**: Uses lazy loading for plugins and functions
- **Neovim**: NvChad uses lazy loading for plugins
- **fzf**: Configured with preview windows and custom options for performance
- **zoxide**: Smart directory navigation with caching

## Troubleshooting

### Common Issues

1. **Stow Conflicts**: If files exist in target locations, remove them before running stow
2. **Fish Functions**: Functions are automatically loaded - no manual sourcing needed
3. **Fish Configuration**: Modular architecture means each component loads independently - check individual files if issues arise
4. **Environment Variables**: Check `.config/fish/env/env.fish` for core variables, `.config/fish/env/path.fish` for PATH issues
5. **Git Signing**: Requires 1Password CLI and SSH key setup
6. **Terminal Themes**: Both Ghostty and Alacritty configs exist - choose one primary terminal

### Validation Commands

```bash
# Test Stow installation
stow . --target=$HOME --simulate

# Test Fish configuration (modular architecture)
fish -c "source ~/.config/fish/config.fish; echo 'Fish config loaded'"

# Test individual Fish modules
fish -c "source ~/.config/fish/env/env.fish; echo 'Environment variables loaded'"
fish -c "source ~/.config/fish/env/path.fish; echo 'PATH configuration loaded'"
fish -c "source ~/.config/fish/env/aliases.fish; echo 'Aliases loaded'"

# Test Fish functions
fish -c "functions | grep -E '(cat|ls|tree)'"

# Test Git configuration
git config --list | grep -E "(user|gpg|commit)"

# Test Homebrew packages
brew list | grep -E "(fish|neovim|tmux|starship)"
```

This repository represents a sophisticated, modern development environment setup that prioritizes automation, security, and developer experience. Any modifications should maintain these principles while adding new functionality.
