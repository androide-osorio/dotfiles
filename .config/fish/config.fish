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
