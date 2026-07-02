set encoding=utf-8

set exrc
set secure

set expandtab
set relativenumber

set showbreak=↯\
set list
set listchars=tab:……,eol:↼,nbsp:␣,trail:∘,extends:⟩,precedes:⟨

set noswapfile

set textwidth=0
set formatoptions-=t

let mapleader = '-'
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['^\.git$']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ale_linters = {}

augroup Text
        autocmd!
augroup END

noremap <c-k> :NERDTreeFind<CR>
noremap <c-a> :Rg<CR>
noremap <c-f> :FZF<CR>

let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!node_modules/**' -g '!dist/**' -g '!out/**' -g '!.git/**'"
