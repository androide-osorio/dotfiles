# initialize homebrew
fish_add_path /opt/homebrew/bin

# initialize starship
starship init fish | source

# rust path config
set PATH $HOME/.cargo/bin $PATH
