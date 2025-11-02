# AGENTS.md - LLM Agent Configuration Guide

## Repository Overview

**Owner**: Andrés Osorio (@androide-osorio)
**Purpose**: Automated dev environment setup for macOS
**Architecture**: Layered installation with GNU Stow symlink management
**Platform**: macOS (ARM64/Intel)

## Core Architecture

### 1. Configuration Management

- **Tool**: GNU Stow (symlink-based dotfile management)
- **Command**: `stow . --target=$HOME` (in `setup.sh`)
- **Structure**: Maintains directory hierarchy via symlinks
- **Ignore**: `.stow-local-ignore` filters relevant files
- **Benefits**: Easy install/uninstall, no conflicts, clean separation

### 2. Layered Installation Strategy

Six-layer setup with independent failure handling:

1. **Package Management** (`scripts/brew.prepare.sh`)
2. **Shell setup** (`scripts/shell.prepare.sh`)
3. **Security Setup** (`scripts/ssh.prepare.sh`)
4. **Development Environments** (`scripts/devenvs.prepare.sh`)
5. **Editor Configuration** (`scripts/vim.prepare.sh`)
6. **Environment Variables** (`scripts/env.prepare.sh`)

## Package Management (Homebrew)

### Brewfile Structure

- **Taps**: homebrew/bundle, homebrew/core, homebrew/cask, homebrew/cask-versions, homebrew/cask-fonts
- **Categories**: CLI tools and macOS applications

### Critical Dependencies

- **asdf**: Universal version manager
- **fish**: Modern shell
- **neovim**: Primary editor (NvChad)
- **stow**: Dotfile management
- **starship**: Cross-shell prompt
- **fzf**: Fuzzy finder with integrations

## Shell Configuration (Fish)

### Architecture Overview

Fish shell configured with modular architecture—each file handles a specific concern.

**Benefits**: Separation of concerns, maintainability, security (isolated secrets), performance (lazy loading), collaboration-friendly, testable components, reduced merge conflicts

### Directory Structure

```txt
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

Loads modular components in order: environment → paths → aliases → integrations → tools.

```fish
source $HOME/.config/fish/env/env.fish
if test -f $HOME/.config/fish/env/secrets.fish
  source $HOME/.config/fish/env/secrets.fish
end
source $HOME/.config/fish/env/path.fish
# ... more setup files
```

**Design Principles**: Single responsibility per file, conditional loading, logical ordering

### Environment Configuration (`env/`)

- **env.fish**: Core environment variables (single source of truth)
- **path.fish**: PATH management (prevents duplicates, ensures order)
- **aliases.fish**: Common command aliases

### Custom Integrations (`custom/`)

- **setup_fzf.fish**: FZF configuration
- **completions.fish**: CLI tool completions
- **git_fzf.fish**: Git + FZF integration (key bindings, preview windows)

### Function Overrides (`functions/`)

Utility functions for command overrides (`cat`, `ls`, etc.). **Patterns**: Wrapper (maintains compatibility), metadata (`--wraps`, `--description`), argument forwarding (`$argv`)

### Auto-Loading Configuration (`conf.d/`)

- **asdf.fish**: ASDF shim setup (auto-loads, PATH management, variable cleanup)

### Design Patterns Used

1. **Template**: `secrets.tpl.fish` → `secrets.fish` (prevents secret commits)
2. **Wrapper**: Function overrides maintain compatibility
3. **Modular Loading**: Independent components for easier debugging
4. **Conditional Loading**: Safe optional component loading
5. **Orchestrator**: Main config coordinates module loading

## Terminal Configuration

### Ghostty Terminal (`.config/ghostty/config`)

- **Theme**: Catppuccin Frappe
- **Font**: JetBrainsMono Nerd Font Mono (16pt)
- **Features**: Background blur, quick terminal, custom keybindings
- **Window**: 135x40 with padding

## Tmux Configuration (`.config/tmux/tmux.conf`)

**Bindings**: Prefix `Ctrl+a`, Split `|`/`-`, Panes `Alt+Arrow`, Reload `r`
**Design**: Mouse enabled, base index 1, custom status bar, no window renaming

## Git Configuration (`.gitconfig`)

**Features**: SSH commit signing (1Password), aliases, Git LFS, custom branch formatting
**Aliases**: `a`→add, `st`→status, `cm`→commit -m, `amendit`→amend --no-edit, `br`→branches, `lg`→graph log

## Development Environment Setup

### asdf Configuration (`scripts/devenvs.prepare.sh`)

- **Languages**: Python, Rust, Node.js (latest versions, set as global)

### Neovim Configuration (`scripts/vim.prepare.sh`)

- **Distribution**: NvChad (Git clone depth 1)
- **Config**: `.config/nvim/lua/chadrc.lua`
- **Settings**: Palenight theme, italic comments, custom statusline/tabufline, lazy loading

## SSH Configuration (`scripts/ssh.prepare.sh`)

- **Algorithm**: ed25519
- **Integration**: GitHub CLI auto-upload
- **Features**: SSH agent management, validates existing keys before generation

## Environment Variable Management

### Secure API Key Management System (`scripts/env.prepare.sh`)

**Architecture**: Template `.config/fish/env/secrets.tpl.fish` (committed) → `secrets.fish` (gitignored, created from template). Managed via Stow, loaded conditionally by Fish config.

**Security**: `secrets.fish` gitignored via `.stow-local-ignore`, template contains only safe examples, supports 1Password CLI (`op read`), consistent structure across machines.

**Setup**: `env.prepare.sh` creates `secrets.fish` from template → user adds API keys → `stow` syncs → Fish loads at startup.

**Benefits**: Zero secret exposure, automated setup, flexible (direct keys or 1Password), template versioned but secrets not.

## Starship Prompt (`.config/starship.toml`)

Uses official schema, initialized in Fish shell with commandline compatibility fix.

## Installation Scripts

### Main Setup Script (`setup.sh`)

**Order**: brew → ssh → devenvs → vim → env → stow
**Features**: `check_command_success()` error handling, step validation before proceeding

### Individual Scripts

All include: error checking, user-friendly output, graceful failure handling, dependency verification

## File Structure

```bash
.dotfiles/
├── .config/
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

### Quick Start

**Prerequisites**: macOS (ARM64/Intel), internet connection, GitHub account

```bash
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && chmod +x setup.sh && ./setup.sh
```

**What Gets Installed**: Homebrew + packages, SSH keys (interactive), Python/Rust/Node.js via asdf, Neovim (NvChad), env var management, config symlinks

**Post-Install**: Fish shell (default), Neovim (NvChad), Tmux, fzf, Starship, modern CLI tools (bat, lsd, ripgrep, zoxide), GUI apps (Arc, VS Code, Docker, etc.)

**Customization**: `chsh -s /opt/homebrew/bin/fish`, edit `~/.config/fish/config.fish`, `~/.config/nvim/lua/chadrc.lua`, `~/.config/tmux/tmux.conf`

**Notes**: Backup first, SSH script generates new keys (use existing if preferred), edit `~/.config/fish/env/secrets.fish` for API keys, Ghostty recommended terminal

**Uninstall**: `cd ~/.dotfiles && stow . --target=$HOME --delete`, optional: `brew bundle cleanup --file=Brewfile`

## Usage Commands

### Initial Setup

```bash
git clone https://github.com/androide-osorio/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && chmod +x setup.sh && ./setup.sh
```

### Manual Installation

```bash
./scripts/brew.prepare.sh        # Homebrew packages & GUI apps
./scripts/ssh.prepare.sh         # SSH keys (interactive)
./scripts/devenvs.prepare.sh     # Python/Rust/Node.js via asdf
./scripts/vim.prepare.sh         # Neovim (NvChad)
./scripts/env.prepare.sh         # Environment variables
stow . --target=$HOME            # Symlink configs
```

### Updating

```bash
brew bundle --file=Brewfile                           # Update packages
asdf update && asdf install python/rust/nodejs latest  # Update languages
cd ~/.config/nvim && git pull                         # Update Neovim
cd ~/.dotfiles && stow . --target=$HOME --restow      # Re-symlink
```

### Testing

```bash
which fish neovim tmux starship fzf bat lsd           # Verify tools
fish -c "echo 'Fish working'"                         # Test Fish
git config --list | grep -E "(user|gpg|commit)"       # Test Git
ls -la ~/.config/fish/config.fish ~/.tmux.conf ~/.gitconfig  # Test symlinks
```

### Uninstalling

```bash
cd ~/.dotfiles && stow . --target=$HOME --delete      # Remove configs
brew bundle cleanup --file=Brewfile                   # Remove packages (optional)
asdf uninstall python/rust/nodejs latest             # Remove languages (optional)
```

### Troubleshooting Commands

```bash
stow . --target=$HOME --simulate                      # Check Stow status
fish -c "functions | grep -E '(cat|ls|tree)'"         # Verify Fish functions
fish -c "fzf --version"                                # Test fzf
git config --get commit.gpgsign                       # Check Git signing
ssh-add -l && gh auth status                          # Validate SSH
```

## Agent Guidelines

### When Modifying This Repository

1. **Respect Stow Structure**: Configs in proper `.config/` subdirectories
2. **Update Scripts Carefully**: Maintain error handling pattern
3. **Test Layer Independence**: Each installation layer works independently
4. **Maintain Compatibility**: Support ARM64 and Intel macOS
5. **Document Changes**: Update this file when adding tools/configs

### Common Modifications

**Adding Tools**: Add to `Brewfile` (package) or casks (GUI app) → add config to `.config/` subdirectory → update scripts if needed → test with `stow . --target=$HOME`

**Shell Config**:

- **Environment**: `.config/fish/env/env.fish` (core vars), `path.fish` (PATH), `aliases.fish` (aliases)
- **Functions**: `.config/fish/functions/` (command overrides)
- **Integrations**: `.config/fish/custom/` (completions in `completions.fish`)
- **Orchestration**: `.config/fish/config.fish` (only for orchestration changes)
- Test: `fish -c "source ~/.config/fish/config.fish"`

**Terminal Themes**: Add to `.config/ghostty/` → update imports → test

### Security Considerations

- **Environment Variables**: Template system prevents secret commits
- **SSH Keys**: Interactive generation (maintain practice)
- **Git Signing**: 1Password SSH-based signing
- **Templates**: Safe examples only, no real secrets

### Performance Notes

- **Fish Shell**: Lazy loading for plugins/functions
- **Neovim**: NvChad lazy loading
- **fzf**: Preview windows, custom options
- **zoxide**: Smart directory navigation with caching

## Troubleshooting

### Common Issues

1. **Stow Conflicts**: Remove existing files in target locations before running stow
2. **Fish Functions**: Auto-loaded, no manual sourcing needed
3. **Fish Configuration**: Modular architecture—components load independently, check individual files if issues arise
4. **Environment Variables**: Check `.config/fish/env/env.fish` (core vars), `path.fish` (PATH issues)
5. **Git Signing**: Requires 1Password CLI and SSH key setup

### Validation Commands

```bash
stow . --target=$HOME --simulate                                    # Test Stow
fish -c "source ~/.config/fish/config.fish; echo 'Config loaded'"   # Test Fish config
fish -c "source ~/.config/fish/env/env.fish; echo 'Env loaded'"     # Test env module
fish -c "source ~/.config/fish/env/path.fish; echo 'Path loaded'"   # Test path module
fish -c "source ~/.config/fish/env/aliases.fish; echo 'Aliases loaded'"  # Test aliases
fish -c "functions | grep -E '(cat|ls|tree)'"                      # Test functions
git config --list | grep -E "(user|gpg|commit)"                     # Test Git
brew list | grep -E "(fish|neovim|tmux|starship)"                  # Test packages
```

This repository prioritizes automation, security, and developer experience. Maintain these principles when making modifications.
