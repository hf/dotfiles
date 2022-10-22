set encoding=utf-8

set exrc
set secure

set expandtab
set relativenumber

set showbreak=↯\
set list
set listchars=tab:……,eol:↼,nbsp:␣,trail:∘,extends:⟩,precedes:⟨

set noswapfile

let mapleader = '-'
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['^\.git$']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ale_linters = {}

augroup Text
        autocmd!
        autocmd FileType markdown :set tw=79
augroup END

noremap <c-k> :NERDTreeFind<CR>
noremap <c-a> :Ag<CR>
noremap <c-f> :FZF<CR>

