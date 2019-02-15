let mapleader = "-"

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = [ "eslint", "jshint" ]
let g:syntastic_typescript_checkers = [ "tsuquyomi" ]

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
  \ 'javascript': ['language-server']
  \ }

let g:tsuquyomi_disable_quickfix = 1
let g:tsuquyomi_completion_detail = 1
autocmd FileType typescript setlocal completeopt+=menu,preview 

autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
autocmd FileType typescript nmap <buffer> <Leader>e <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>E <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <buffer> <Leader>z <Plug>(TsuquyomiDefinition)
autocmd FileType typescript nmap <buffer> <Leader>Z <Plug>(TsuquyomiTypeDefinition)
autocmd FileType typescript nmap <buffer> <Leader>s <Plug>(TsuquyomiGeterr)
autocmd FileType typescript nmap <buffer> <Leader>S <Plug>(TsuquyomiGeterrProject)
autocmd FileType typescript nmap <buffer> <Leader>f <Plug>(TsuquyomiReferences)

augroup neoformatting
  autocmd!
  autocmd BufWritePre * | Neoformat
augroup END

let g:neoformat_enabled_c = []
let g:neoformat_enabled_cpp = []
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_run_all_formatters = 1

set rtp+=~/.fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~35%' }

nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '~35%',
\   'sink': 'botright split' })<CR>
