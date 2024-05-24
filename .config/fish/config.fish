set fish_greeting

# initialize homebrew
fish_add_path /opt/homebrew/bin

# Environment variables - https://fishshell.com/docs/current/cmds/set.html
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -gx DOTFILES "$HOME/dotfiles"

# rust path config
set PATH $HOME/.cargo/bin $PATH

# aliases
alias . 'pwd'
alias ll 'ls -la'
alias vim 'nvim'
alias vi 'nvim'
alias ls 'lsd --group-dirs first'

# Set up fzf key bindings
fzf --fish | source

# zoxide setup
zoxide init --cmd cd fish | source

# Setting PATH for Python 3.10
# The original version is saved in /Users/androide.osorio/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

# initialize starship
starship init fish | source
