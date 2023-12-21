# initialize homebrew
fish_add_path /opt/homebrew/bin

# rust path config
set PATH $HOME/.cargo/bin $PATH

# fnm setup
fnm env | source

# Setting PATH for Python 3.10
# The original version is saved in /Users/androide.osorio/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"

# initialize starship
starship init fish | source
