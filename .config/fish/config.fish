set fish_greeting

# initialize homebrew
fish_add_path /opt/homebrew/bin

# Environment variables - https://fishshell.com/docs/current/cmds/set.html
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -gx DOTFILES "$HOME/.dotfiles"
set -gx LANG en_US.UTF-8

# rust path config
set PATH $HOME/.cargo/bin $PATH

# aliases
alias . 'pwd'
alias ll 'ls -la'
alias vim 'nvim'
alias vi 'nvim'

# Set up fzf key bindings
fzf --fish | source

# zoxide setup
zoxide init --cmd cd fish | source

# initialize starship
starship init fish | source
