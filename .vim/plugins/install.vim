"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspired from:
"       awesome-vim repository:
"       https://github.com/Olical/dotfiles
"
" This file contains the list of all the plugins I use in VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
  Plug 'sheerun/vim-polyglot'

  "IDE
  Plug 'easymotion/vim-easymotion'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'pechorin/any-jump.vim'

  " UI
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'itchyny/lightline.vim'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'sodapopcan/vim-twiggy'
  Plug 'jreybert/vimagit'
  Plug 'airblade/vim-gitgutter'

  " Themes
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
call plug#end()

" Load plugin configs
for file in split(glob(Dot("plugins/config/*.vim")), "\n")
  let name = fnamemodify(file, ":t:r")

  if exists("g:plugs[\"" . name . "\"]")
    exec "source" file
  else
    echom "No plugin found for config file " . file
  endif
endfor
