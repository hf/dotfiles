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
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\u2717"
let g:syntastic_warning_symbol = "\u26A0"

let g:syntastic_javascript_checkers = [ "eslint", "jshint" ]
let g:syntastic_typescript_checkers = [ "tsuquyomi" ]

let g:syntastic_mode_map = {
  \ "mode": "active",
  \ "active_filetypes": ["typescript"],
  \ "passive_filetypes": ["javascript", "cpp", "c"]
  \ }

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['ccls'], 
  \ 'c':   ['ccls'],
  \ 'cuda': ['ccls'],
  \ 'objc': ['ccls']
  \ }
let g:LanguageClient_settingsPath = '~/.config/nvim/language-client-settings.json'

function SetLSPShortcuts()
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
  nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
  nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
endfunction()

augroup LSP
  autocmd!
  autocmd FileType cpp,c call SetLSPShortcuts()
augroup END

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

set rtp+=~/.fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'down': '~35%' }

nnoremap <silent> <Leader>s :FZF<CR>
