call plug#begin('~/.vim/plugged')
  " S tier plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'chaoren/vim-wordmotion'
  Plug 'junegunn/fzf.vim', {'branch': 'master'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'easymotion/vim-easymotion'
  Plug 'sheerun/vim-polyglot'
  Plug 'wellle/targets.vim'
  Plug 'rhysd/clever-f.vim'

  " A tier
  Plug 'machakann/vim-swap'
  Plug 'airblade/vim-rooter'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'

  " Whatever tier
  Plug 'airblade/vim-gitgutter'
  Plug 'preservim/nerdtree'
  Plug 'liuchengxu/vim-which-key'
  Plug 'kshenoy/vim-signature'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'ervandew/supertab'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/vim-peekaboo'

  Plug 'lucapette/vim-textobj-underscore'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-methodcall'
  Plug 'kana/vim-textobj-user'
  Plug 'glts/vim-textobj-comment'
  Plug 'thalesmello/vim-textobj-methodcall'
  Plug 'Julian/vim-textobj-brace'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'michaeljsmith/vim-indent-object'

  " Themes
  Plug 'ryanoasis/vim-devicons'
  Plug 'psliwka/vim-smoothie'
  Plug 'itchyny/lightline.vim'
  Plug 'rakr/vim-one'
call plug#end()
