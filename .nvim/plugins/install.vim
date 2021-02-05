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

  " UI
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'itchyny/lightline.vim'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'

  " Themes
  Plug 'hzchirs/vim-material'
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