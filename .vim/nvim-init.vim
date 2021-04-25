"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Neo VIM configuration. This file just synchronizes
" NVIM's configuration with VIM/s, so both editors
" have feature and configuration parity
"
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspiration:
"       Nicolar Shurmann's VIM course in Udemy:
"           https://github.com/amix/vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" load content in .vimrc
source ~/.vimrc
