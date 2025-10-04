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
