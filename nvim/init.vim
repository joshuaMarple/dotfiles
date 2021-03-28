call plug#begin('~/.vim/plugged')
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'
  Plug 'kabouzeid/nvim-lspinstall'

  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'

  "" Buffer Navigation
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'junegunn/fzf.vim', {'branch': 'master'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'rhysd/clever-f.vim'

  Plug 'dbakker/vim-projectroot'
  Plug 'ervandew/supertab'

  Plug 'mhinz/vim-signify'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'mhinz/vim-startify'
  Plug 'tmsvg/pear-tree'
  Plug 'tommcdo/vim-exchange'
  Plug 'jremmen/vim-ripgrep'
  Plug 'stefandtw/quickfix-reflector.vim'
  Plug 'qpkorr/vim-bufkill'
  Plug 'romainl/vim-qf'
  Plug 'ojroques/vim-oscyank'
  Plug 'svermeulen/vim-subversive'

  "" Terminal Management
  Plug 'kassio/neoterm'
  Plug 'voldikss/vim-floaterm'

  "" Textobjects
  Plug 'wellle/targets.vim'
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-line'
  Plug 'glts/vim-textobj-comment'
  Plug 'Julian/vim-textobj-variable-segment'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'Chun-Yang/vim-textobj-chunk'
  Plug 'pianohacker/vim-textobj-indented-paragraph'

  "" Themes
  Plug 'sheerun/vim-polyglot'
  " Turns off highlighting intelligently
  Plug 'romainl/vim-cool'
  Plug 'ryanoasis/vim-devicons'
  " Renders colors inline
  Plug 'tjdevries/colorbuddy.vim'
  " Smoothes scrolling up and down
  Plug 'psliwka/vim-smoothie'
  Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'datwaft/bubbly.nvim'
call plug#end()

" Needed for compe (https://github.com/hrsh7th/nvim-compe)
set completeopt=menuone,noselect

filetype plugin indent on
syntax on

" Set working directory to same as buffer
set autochdir

" How many ex commands should be stored in history
set history=10000
" Oldfiles is set from loading shada marks. Even if a file doesn't have a
" manually set mark, the default ' mark will load, populating oldfiles.
" https://neovim.io/doc/user/eval.html#v:oldfiles
set shada='10000

" Min lines that should show when scrolling.
set scrolloff=5

" Relative numbers cause slow rendering, and are inconvenient for ex ranges.
set number

" Set a persistent undo, and store them in one dir.
set undofile
set undodir=~/.vim/undo

" Netrw does the job
let g:netrw_banner=0
let g:netrw_liststyle = 3

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers and show before
" replacement.
set incsearch
set inccommand=split

" Don't redraw while executing macros (good performance config)
set lazyredraw

set termguicolors

set background=light
colorscheme one

set splitbelow
set splitright

" Max time to wait on terminal response
set timeoutlen=1000
set ttimeoutlen=5
set updatetime=300

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" Use nvr to edit files (prevents nesting)
let $VISUAL="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $FPP_EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"

let mapleader = " "

""" FZF
nnoremap <leader>s :GitStat<CR>
nnoremap <leader>o :Bookmarks<CR>
nnoremap <leader>p :ProjectFiles<CR>
nnoremap ,, :Telescope buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>h :Telescope oldfiles<CR>
nnoremap <leader>; :Telescope command_history<CR>
nnoremap <leader>d :Telescope help_tags<CR>
nnoremap <leader>q :Telescope quickfix<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <leader>g :Rip<CR>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>rr :Telescope file_browser<CR>
nnoremap <leader>H :FloatermNew htop<CR>

nnoremap <leader>Q <cmd>q<CR>
nnoremap <leader>tr :T !!<CR>
nnoremap <leader>tv <cmd>vsplit <bar> Tnew<CR>
nnoremap <leader>tn <cmd>Tnew<CR>
nnoremap <leader>tt :Ttoggle<CR>

" Mapping selecting mappings
imap <c-x><c-k> <Plug>(fzf-complete-word)
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)

" I hate horizontal splitting
cabbrev h vert h

map <C-n> :cn<CR>
map <C-p> :cp<CR>

nnoremap <leader>nt :call NumToggle()<CR>
nnoremap <leader>nh :noh<CR>

nmap<leader>w :w<CR>

" Allows for inserting before and after text objects
nnoremap <silent> ,a :set opfunc=Append<CR>g@
nnoremap <silent> ,i :set opfunc=Insert<CR>g@

" semicolon is easier than colon, and smart-f takes precedence
nnoremap ; :
vnoremap ; :

" easier window nav
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>

let g:textobj_comment_no_default_key_mappings = 1
xmap ax <Plug>(textobj-comment-a)
omap ax <Plug>(textobj-comment-a)
xmap ix <Plug>(textobj-comment-i)
omap ix <Plug>(textobj-comment-i)
xmap aX <Plug>(textobj-big-a)
omap aX <Plug>(textobj-big-a)
xmap iX <Plug>(textobj-big-i)
omap iX <Plug>(textobj-big-a)

" Terminal should automatically go into insert mode
autocmd BufWinEnter,WinEnter term://* startinsert

tnoremap ,, <C-\><C-n>:Buffers<CR>
tnoremap uu <C-\><C-n>

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>

nmap gs <Plug>(operator-ripgrep-root)
vmap gs <Plug>(operator-ripgrep-root)
call operator#user#define('ripgrep-root', 'OperatorRip', 'call SetRipOpDir(projectroot#guess())')

nmap gx <cmd>Rg<CR>
vmap gx <cmd>Rg<CR>

nmap g. <Plug>(operator-ripgrep-cwd)
vmap g. <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')

vnoremap <leader>c :OSCYank<CR>

" Textobjects subversion and substitution
nmap ,s <plug>(SubversiveSubstituteRange)
xmap ,s <plug>(SubversiveSubstituteRange)
nmap ,ss <plug>(SubversiveSubstituteWordRange)

nmap ,S <plug>(SubversiveSubvertRange)
xmap ,S <plug>(SubversiveSubvertRange)
nmap ,Ss <plug>(SubversiveSubvertWordRange)

" Easier quickfix management
nmap <leader>qs <Plug>(qf_qf_switch)
nmap <leader>qt <Plug>(qf_qf_toggle)
nmap <leader>qr <cmd>RefreshQuickFix()<CR>
nmap <leader>qq <cmd>Telescope quickfix<CR>

" Config editing/reloading
nmap <leader>rc <cmd>so %<CR>
nmap <leader>rp <cmd>PlugInstall<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Easier nav with alt
map <A-c> :cn<CR>
map <A-S-c> :cp<CR>
nnoremap <A-t> :tabnext<CR>
nnoremap <A-S-t> :tabprevious<CR>
tnoremap <A-t> <C-\><C-n>:tabnext<CR>
tnoremap <A-S-t> <C-\><C-n>:tabprevious<CR>

" Keep work stuff separate
runtime ~/.config/nvim/work.vim
