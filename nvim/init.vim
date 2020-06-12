""""" PLUGGED """""
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/limelight.vim', { 'on': 'GoyoEnter' }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'integralist/vim-mypy', { 'for': 'python' }
Plug 'psf/black', { 'for': 'python' }
call plug#end()

let g:goyo_width = '90%'
let g:goyo_height = '90%'
let g:limelight_conceal_ctermfg = 'Gray'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
autocmd! User GoyoEnter setlocal spell
autocmd! User GoyoEnter setlocal nospell
let g:go_fmt_autosave = 1
let g:rustfmt_autosave = 1
autocmd BufWritePre *.py execute ':Mypy'
autocmd BufWritePre *.py execute ':Black'

""""" SCRIPTING """""
" python -m venv "~/.config/nvim/venv"
let g:python3_host_prog = expand('~/.config/nvim/venv/bin/python')

""""" COLORSCHEME """""
colorscheme gruvbox
set background=dark

""""" NETRW """""
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=2 " open in vertical split
let g:netrw_altv=1
let g:netrw_winsize=20 "window size of 25 cols
function! ToggleVExplorer() " Toggle Vexplore with Ctrl-E
    if exists('t:expl_buf_num')
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec 'wincmd w'
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
         Vexplore
         let t:expl_buf_num = bufnr('%')
    endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

""""" MISC """""
" filetype plugin indent on
" set backspace=indent,eol,start
set mouse=nicr " set mouse=a
syntax enable
set encoding=utf-8
set spelllang=en_us
set wrap linebreak
set number
set updatetime=300

""""" F&R """""
set hlsearch
set incsearch
set ignorecase
set smartcase

""""" *.swp """""
set nobackup 
set nowritebackup

