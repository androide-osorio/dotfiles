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
