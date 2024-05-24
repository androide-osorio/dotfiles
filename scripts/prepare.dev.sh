#!/usr/bin/env bash
# Verify asdf is installed using an if statement. If it is not, echo an error "ASDF is not installed. Aborting..." and exit the script with a non zero code
asdf --version || exit 1

# Install asdf plugins for ruby, nodejs, python, and rust
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs
asdf plugin add python https://github.com/asdf-community/asdf-python
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby
asdf plugin add rust https://github.com/code-lever/asdf-rust

# Install latest versions of ruby, nodejs, python, and rust
asdf install nodejs latest
asdf install python latest
asdf install ruby latest
asdf install rust latest

# Set global versions of all environments
asdf global nodejs latest
asdf global python latest
asdf global ruby latest
asdf global rust latest
