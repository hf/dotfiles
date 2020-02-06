call plug#begin()

Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdtree'

Plug 'vim-syntastic/syntastic'

Plug 'Shougo/vimproc', { 'do': 'make' }

Plug 'leafgarland/typescript-vim'

Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

Plug 'editorconfig/editorconfig-vim'

Plug 'rust-lang/rust.vim'

Plug 'udalov/kotlin-vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

if has('nvim')
else
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'roxma/nvim-yarp'
endif

call plug#end()
