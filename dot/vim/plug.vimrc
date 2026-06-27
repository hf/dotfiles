call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

Plug 'editorconfig/editorconfig-vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'elixir-editors/vim-elixir'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'hf/vim-typespec'

call plug#end()
