#!/usr/bin/env bash

DOTFILES=$(pwd)
CONFIG_VIM=$HOME/.config/vim
CONFIG_NVIM=$HOME/.config/nvim
INCLUDE_NVIM=0

# read command options
for args in "$@"; do
	case "$args" in
		--include-nvim) INCLUDE_NVIM=1;;
	esac
done

if [ ! -d $CONFIG_VIM ]; then
  mkdir -p $CONFIG_VIM
fi

mkdir -p $CONFIG_VIM/undo $CONFIG_VIM/spell $CONFIG_VIM/autoload

# Install VIM Plug if it doesn't already exist
if [ ! -f $CONFIG_VIM/autoload/plug.vim ]; then
  curl -fLo $CONFIG_VIM/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# symlink .vim folder to $CONFIG_VIM
ln -sf $CONFIG_VIM ~/.vim

# Symlink VIM files with config files
ln -sf $DOTFILES/.vim/*/ $CONFIG_VIM
ln -sf $DOTFILES/.vim/init.vim $CONFIG_VIM/init.vim
# ln -s $DOTFILES/.vim/plugins.vim $CONFIG_VIM/plugins.vim

# symlink to .vimrc to $CONFIG_VIM/init.vim
ln -sf $CONFIG_VIM/init.vim ~/.vimrc

# update and install plugins
vim +"PlugSnapshot! $CONFIG_VIM/snapshot.vim" +PlugUpgrade +PlugClean! +PlugUpdate +qa
vim +UpdateRemotePlugins +qa

if [ $INCLUDE_NVIM -eq 1 ]; then
  # create cofnig folder if it does not exist
  if [ ! -d $CONFIG_VIM ]; then
    mkdir -p $CONFIG_NVIM
  fi
  # symlink nvim individual config
  ln -sf $DOTFILES/.vim/nvim-init.vim $CONFIG_NVIM/init.vim
fi

echo "Installed the Basic Vim configuration successfully! Enjoy :-)"
