"""""FILETYPE"""""
filetype plugin indent on " detection, indentation, plugins for filetypes

""""" MISC """""
color pablo
syntax enable
set encoding=utf-8
set spelllang=en_us
set wrap linebreak
set number
" set relativenumber
set backspace=indent,eol,start
" set mouse=nicr
set mouse=a "only allows for mouse scrolling
set nobackup "no backup files -- for windows those are *~ files
set nowritebackup "no backup files -- for windows those are *~ files

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'}
Plug 'rust-lang/rust.vim'
Plug 'python/black'
Plug 'integralist/vim-mypy'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

let g:go_fmt_autosave = 1
let g:rustfmt_autosave = 1
autocmd BufWritePre *.py execute ':Black'
let g:limelight_conceal_ctermfg = 'Gray'
let g:goyo_width = '90%'
let g:goyo_height = '90%'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoEnter setlocal spell
autocmd! User GoyoLeave setlocal nospell
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
