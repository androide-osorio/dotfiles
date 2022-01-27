#!/usr/bin/env bash
DOTFILES_PATH=$(pwd)
CONFIG_FISH=$HOME/.config/fish

# Symlink fish config
ln -sf $DOTFILES_PATH/.fish/*/ $CONFIG_FISH
ln -sf $DOTFILES_PATH/.fish/config.fish $CONFIG_FISH/config.fish
ln -sf $DOTFILES_PATH/.fish/fish_variables $CONFIG_FISH/fish_variables

echo "🎏Fish config synced successfully!"
echo "Exiting..."
