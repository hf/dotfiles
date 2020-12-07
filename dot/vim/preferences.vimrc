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

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

let g:ale_linters = {}

" To add LanguageClient in a project add a .vimrc file and set
" let g:LanguageClient_rootMarkers = { 'lang': ['.vimrc'] }
" let g:LanguageClient_serverCommands = { 'lang': ['path-to-client'] }

let g:LanguageClient_loggingLevel = 'WARN'
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_serverCommands = {}

nnoremap <Leader>m :call LanguageClient#contextMenu()<CR>
nnoremap <Leader>h :call LanguageClient#textDocument_hover({ 'gotoCmd': 'split' })<CR>
nnoremap <Leader>d :call LanguageClient#textDocument_definition({ 'gotoCmd': 'split' })<CR>
nnoremap <Leader>t :call LanguageClient#textDocument_typeDefinition({ 'gotoCmd': 'split' })<CR>
nnoremap <Leader>i :call LanguageClient#textDocument_implementation({ 'gotoCmd': 'split' })<CR>
nnoremap <Leader>u :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>a :call LanguageClient#textDocument_codeAction()<CR>
nnoremap <Leader>f :call LanguageClient#textDocument_formatting()<CR>
nnoremap <Leader>r :call LanguageClient#textDocument_rename()<CR>

augroup Text
        autocmd!
        autocmd FileType markdown :set tw=79
augroup END
