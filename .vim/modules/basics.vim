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
set noshowmode
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

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

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
" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511
if (has('termguicolors'))
  set termguicolors
endif
syntax on
syntax enable
set background=dark

" Palenight
let g:material_theme_style = 'palenight_community'
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
