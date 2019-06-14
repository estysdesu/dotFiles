"""""FILETYPE"""""
filetype plugin indent on "detection, indentation, plugins for filetypes

"""""MISC"""""
color pablo
syntax enable
set encoding=utf-8
set wrap
set number
"set relativenumber
set backspace=indent,eol,start
"set mouse=nicr
set mouse=a "only allows for mouse scrolling

"""""F&R"""""
set hlsearch
set incsearch
set ignorecase
set smartcase

"""""NETRW"""""
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=2 "open in vertical split
let g:netrw_altv=1
let g:netrw_winsize=25 "window size of 25 cols
source $HOME/.vim/myPlugins/netrwToggle.vim "<C-E> to toggle netrw

"""""PLUGINS"""""
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

