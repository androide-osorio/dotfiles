set fish_greeting

# Key bindings
fish_vi_key_bindings

# initialize homebrew
fish_add_path (brew --prefix)/bin

# Environment variables - https://fishshell.com/docs/current/cmds/set.html
set -gx EDITOR nvim
set -gx GIT_EDITOR nvim
set -gx HOMEBREW_CASK_OPTS '--appdir=/Applications'
set -gx DOTFILES "$HOME/.dotfiles"
set -gx BAT_THEME 'OneHalfDark'
set -gx LANG en_US.UTF-8

# rust path config
set PATH $HOME/.cargo/bin $PATH

# aliases
alias . 'pwd'
alias ll 'ls -la'
alias vim 'nvim'
alias vi 'nvim'

# Set up fzf key bindings
set -gx FZF_DEFAULT_OPTS "--reverse --border double --height 80% --cycle --wrap"
set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --line-range=:500 --style=numbers {}' --preview-window right:60%:wrap"
set -gx FZF_ALT_C_OPTS "--preview 'lsd --group-dirs=first --color=always --tree {} | head -200'"
fzf --fish | source

# Git fzf integration
if status is-interactive && test -f ~/.config/fish/custom/git_fzf.fish
	source ~/.config/fish/custom/git_fzf.fish
	git_fzf_key_bindings
end

# zoxide setup
zoxide init --cmd cd fish | source

# initialize starship
# starship init fish | source
source ~/.config/fish/starship_init.fish

# asdf config
source (brew --prefix asdf)/libexec/asdf.fish
