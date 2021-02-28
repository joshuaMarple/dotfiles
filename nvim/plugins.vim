call plug#begin('~/.vim/plugged')
  " S tier plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'chaoren/vim-wordmotion'
  Plug 'junegunn/fzf.vim', {'branch': 'master'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'easymotion/vim-easymotion'
  Plug 'sheerun/vim-polyglot'
  Plug 'wellle/targets.vim'
  Plug 'rhysd/clever-f.vim'

  " Plug 'nvim-lua/popup.nvim'
  " Plug 'nvim-lua/plenary.nvim'
  " Plug 'nvim-telescope/telescope.nvim'

  " A tier
  Plug 'machakann/vim-swap'
  Plug 'dbakker/vim-projectroot'
  Plug 'haya14busa/incsearch.vim'
  Plug 'haya14busa/incsearch-fuzzy.vim'
  Plug 'haya14busa/incsearch-easymotion.vim'
  Plug 'ervandew/supertab'

  " Whatever tier
  Plug 'liuchengxu/vim-which-key'
  " Plug 'kshenoy/vim-signature' # won't work with signify, maybe in the
  " future
  Plug 'mhinz/vim-signify'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'mhinz/vim-startify'
  Plug 'tmsvg/pear-tree'
  Plug 'tommcdo/vim-exchange'
  Plug 'voldikss/vim-floaterm'
  Plug 'antoinemadec/coc-fzf'
  Plug 'tweekmonster/fzf-filemru'
  Plug 'jremmen/vim-ripgrep'
  Plug 'stefandtw/quickfix-reflector.vim'
  Plug 'inkarkat/vim-ReplaceWithRegister'
  Plug 'wellle/visual-split.vim'
  Plug 'qpkorr/vim-bufkill'
  Plug 'romainl/vim-qf'
  Plug 'ojroques/vim-oscyank'
  Plug 'arp242/jumpy.vim'
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'svermeulen/vim-subversive'
  Plug 'kassio/neoterm'

  " No such thing as too many textobjects
  Plug 'kana/vim-operator-user'
  Plug 'lucapette/vim-textobj-underscore'
  Plug 'kana/vim-textobj-lastpat'
  Plug 'kana/vim-textobj-function'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-line'
  Plug 'glts/vim-textobj-comment'
  Plug 'thalesmello/vim-textobj-methodcall'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'Chun-Yang/vim-textobj-chunk'
  Plug 'pianohacker/vim-textobj-indented-paragraph'
  Plug 'adolenc/vim-textobj-toplevel'
  Plug 'idbrii/textobj-word-column.vim'

  " Themes
  Plug 'humanoid-colors/vim-humanoid-colorscheme'
  Plug 'ryanoasis/vim-devicons'
  Plug 'psliwka/vim-smoothie'
  Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'datwaft/bubbly.nvim'
call plug#end()
