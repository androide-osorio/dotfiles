#!/usr/bin/env bash

DOTFILES=$(pwd)
CONFIG=$HOME/.config/nvim

mkdir -p $CONFIG/undo $CONFIG/spell $CONFIG/autoload

# Install VIM Plug if it doesn't already exist
if [ ! -f $CONFIG/autoload/plug.vim ]; then
  curl -fLo $CONFIG/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Symlink VIM files config files
ln -s $DOTFILES/.nvim/*/ $CONFIG
ln -s $DOTFILES/.nvim/init.vim $CONFIG/init.vim
ln -s $DOTFILES/.nvim/plugins.vim $CONFIG/plugins.vim

# update and install plugins
nvim +"PlugSnapshot! $CONFIG/snapshot.vim" +PlugUpgrade +PlugClean! +PlugUpdate +qa
nvim +UpdateRemotePlugins +qa

echo "Installed the Basic Vim configuration successfully! Enjoy :-)"
