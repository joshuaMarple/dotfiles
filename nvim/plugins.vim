call plug#begin('~/.vim/plugged')
  " S tier plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-obsession'
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
  " Plug 'airblade/vim-rooter'
  Plug 'dbakker/vim-projectroot'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'ervandew/supertab'

  " Whatever tier
  Plug 'airblade/vim-gitgutter'
  Plug 'liuchengxu/vim-which-key'
  Plug 'kshenoy/vim-signature'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'mhinz/vim-startify'
  Plug 'junegunn/vim-peekaboo'
  Plug 'tmsvg/pear-tree'
  Plug 'tommcdo/vim-exchange'
  Plug 'voldikss/fzf-floaterm'
  Plug 'voldikss/vim-floaterm'

  " No such thing as too many textobjects
  Plug 'lucapette/vim-textobj-underscore'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-methodcall'
  Plug 'kana/vim-textobj-user'
  Plug 'glts/vim-textobj-comment'
  Plug 'thalesmello/vim-textobj-methodcall'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'kana/vim-textobj-line'

  " Themes
  Plug 'ryanoasis/vim-devicons'
  Plug 'psliwka/vim-smoothie'
  Plug 'itchyny/lightline.vim'
  " Plug 'rakr/vim-one'
  Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'camspiers/animate.vim'
  Plug 'camspiers/lens.vim'
call plug#end()
