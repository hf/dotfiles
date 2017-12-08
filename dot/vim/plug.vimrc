call plug#begin()

Plug 'tpope/vim-surround'

Plug 'sbdchd/neoformat'

Plug 'scrooloose/nerdtree'

Plug 'vim-syntastic/syntastic'

Plug 'Shougo/vimproc', { 'do': 'make' }

Plug 'leafgarland/typescript-vim'

Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }

Plug 'editorconfig/editorconfig-vim'

Plug 'rust-lang/rust.vim'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins', 'for': ['rust', 'javascript'] }

if has('nvim')
else
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'roxma/nvim-yarp'
endif

call plug#end()
