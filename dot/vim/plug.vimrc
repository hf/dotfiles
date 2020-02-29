call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'dense-analysis/ale'
Plug 'autozimu/LanguageClient-neovim', { 'branch':'next', 'do': 'make release' }

call plug#end()
