
filetype plugin on
filetype plugin indent on

"syntax enable
set encoding=utf-8
set wrap
set number
set relativenumber
set backspace=indent,eol,start

"set mouse=nicr

set hlsearch
set incsearch
set ignorecase
set smartcase

let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=15
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END 

color pablo

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'tpope/vim-vinegar', "file explorer extension on top of netrw

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

