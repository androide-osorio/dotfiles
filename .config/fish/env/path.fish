# Add custom paths to the PATH environment variable
fish_add_path (brew --prefix)/bin
fish_add_path $HOME/.cargo/bin
fish_add_path -a $HOME/.lmstudio/bin
