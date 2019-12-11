"""""FILETYPE"""""
filetype plugin indent on " detection, indentation, plugins for filetypes

""""" MISC """""
color pablo
syntax enable
set encoding=utf-8
set wrap linebreak
set number
" set relativenumber
set backspace=indent,eol,start
" set mouse=nicr
set mouse=a "only allows for mouse scrolling
set nobackup "no backup files -- for windows those are *~ files

""""" FIND & REPLACE """""
set hlsearch
set incsearch
set ignorecase
set smartcase

""""" NETRW """""
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=2 " open in vertical split
let g:netrw_altv=1
let g:netrw_winsize=20 "window size of 25 cols
source $HOME/.vim/myPlugins/netrwToggle.vim "<C-E> to toggle netrw

""""" PLUGINS """""
call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
let g:go_fmt_autosave = 1
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1
" Plug 'python/black'
" autocmd BufWritePre *.py execute ':Black'
" Plug 'integralist/vim-mypy'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
let g:limelight_conceal_ctermfg = 'Gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

call plug#end()

