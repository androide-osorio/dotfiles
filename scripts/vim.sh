#!/bin/bash
set -e

# install "Plug" Plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# copy vim config
cat ./.vim/basics.vim > ~/.vimrc
cat ./.vim/plugins.vim >> ~/.vimrc

echo "Installed the Basic Vim configuration successfully! Enjoy :-)"