call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'autozimu/LanguageClient-neovim', { 'branch':'next', 'do': 'make release' }

Plug 'leafgarland/typescript-vim'

call plug#end()
