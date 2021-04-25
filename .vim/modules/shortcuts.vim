"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keyboard shortcuts
"
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspiration:
"       Nicolas Shurmann VIM course:
"          https://www.udemy.com/share/101C1uCEUSd1dQQw==/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap leader key
let mapleader = "\<Space>"

" common commands
nmap <Leader>w :w<cr>
nmap <Leader>q :q!<cr>

" NERDTree
map <Leader>nn :NERDTreeToggle<cr>
map <Leader>nb :NERDTreeFromBookmark<Space>
map <Leader>nf :NERDTreeFind<cr>

nmap <Leader>s <Plug>(easymotion-s2)
