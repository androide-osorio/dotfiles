"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspired from:
"       awesome-vim repository:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> VIM UI
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plug-ins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
  Plug 'sheerun/vim-polyglot'
	Plug 'preservim/nerdtree'
	Plug 'ryanoasis/vim-devicons'
  Plug 'itchyny/lightline.vim'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'joshdick/onedark.vim'
" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmode
set encoding=UTF-8

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the Wild menu
set wildmenu

" -> additional
" For regular expressions turn magic on
set magic
" Add a bit extra margin to the left
set foldcolumn=1
" Don't redraw while executing macros (good performance config)
set lazyredraw
" Incremental search
set incsearch
"Always show current position
set ruler

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has('termguicolors'))
  set termguicolors
endif
syntax on
syntax enable
colorscheme onedark

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-> line numbers
set number
set relativenumber

" -> indentation
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" 1 tab == 2 spaces
set tabstop=2
set shiftwidth=2
set softtabstop=0
" Be smart when using tabs ;)
set smarttab
" Use spaces instead of tabs
set expandtab

" Linebreak on 500 characters
set lbr
set tw=500

" -> bracket matcher
set showmatch
