"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspiration:
"       awesome-vim repository:
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
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmode
set encoding=UTF-8
set mouse=a

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

" remap leader key
let mapleader = "\<Space>"

" synchronize VIM clipboard with OS clipboard
set clipboard=unnamed

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" show commands when executing
set showcmd
" always show status bar
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if (has('termguicolors'))
  set termguicolors
endif
syntax on
syntax enable
set background=dark

" Palenight
let g:material_theme_style = 'palenight'
let g:material_terminal_italics = 1
colorscheme material

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
set numberwidth=1

" use hybrid numbers on focus and and insert mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" -> indentation
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" 1 tab == 2 spaces
set sw=2
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
