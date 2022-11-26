" Plugins {{{
call plug#begin('~/.vim/plugged')
  " LSP
  Plug 'neovim/nvim-lspconfig'

  Plug 'jmarple/mini.nvim'

  " Plug 'williamboman/nvim-lsp-installer'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " Tpope section
  " Plug 'tpope/vim-surround', {'tag': 'v2.2'}
  Plug 'joshuaMarple/vim-abolish'
  Plug 'joshuaMarple/vim-unimpaired'

  " Buffer Navigation
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', {'tag': 'nvim-0.6'}
  Plug 'nvim-telescope/telescope-file-browser.nvim'

  Plug 'joshuaMarple/diffconflicts'

  Plug 'joshuaMarple/vim-projectroot'

  Plug 'joshuaMarple/quickfix-reflector.vim'
  Plug 'joshuaMarple/vim-qf'
  Plug 'joshuaMarple/vim-oscyank'

  " Terminal Management
  Plug 'joshuaMarple/vim-tmux-navigator'

  " Themes
  Plug 'joshuaMarple/nvim-web-devicons'
  " Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'https://gitlab.com/jmarple/dotline.nvim', {'branch': 'main'}
  Plug 'joshuaMarple/galaxyline.nvim' , {'branch': 'main'}

  " Plug 'joshuaMarple/nvim-colorizer.lua'

  " Profiling
  " Plug 'joshuaMarple/vim-startuptime'
call plug#end() 
"}}}

" {{{ Settings
set cursorline

set foldmethod=marker

" This is in the statusline, I don't need it elsewhere
set noshowmode

" Show a single, global, statusline
set laststatus=3

" Hide the cmdline (only appears when typing in cmd-line mode)
" set cmdheight=0

set completeopt=menu,menuone,noselect

filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
set hidden
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" when shifting, should it round to the next closest width
set shiftround

syntax on

" Set working directory to same as buffer
set autochdir

" How many ex commands should be stored in history
set history=10000

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

set wildcharm=<C-z>
set wildignorecase

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
silent! colorscheme one

" Hide nontext '~' marker for line padding https://stackoverflow.com/questions/3813059/is-it-possible-to-not-display-a-for-blank-lines-in-vim-neovim
hi NonText guifg=bg

set splitright

" Max time to wait on terminal response
set timeoutlen=1000
set ttimeoutlen=5
set updatetime=300

" Use rg for grepping
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Use nvr to edit files (prevents nesting)
let $VISUAL="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $FPP_EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"

let mapleader = " "
"}}}

" Augroups {{{
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
augroup filechanged
  autocmd!
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" }}}

" Mappings {{{
nnoremap <leader>pt :ProfileToggle<CR>
nnoremap <leader>Gg :silent grep 
nnoremap <leader>Gp :silent grep  <C-r>=b:projectroot<CR><S-Left><Left>
nnoremap <leader>e :Vexplore<CR>

nnoremap <leader>Q <cmd>q<CR>

" Vanilla Key Bindings
nnoremap <leader>B :buffer <C-z><S-Tab>
nnoremap <leader>H :browse oldfiles<CR>
nnoremap <leader>D :help 
nnoremap <leader>G :silent grep  <C-r>=b:projectroot<CR><S-Left><Left>
nnoremap <leader>E :Vexplore<CR>
nnoremap <leader>Ff :e <C-Z><S-TAB>
nnoremap <leader>Fp :e <C-r>=b:projectroot<CR>/**/*

nnoremap <Esc> :

" Folding
" Close everything besides what I'm in
nnoremap <leader>zz zMzv

" I hate horizontal splitting
cabbrev h vert h

noremap <C-n> :cn<CR>
noremap <C-p> :cp<CR>

" nnoremap <leader>nt :lua require('numtoggle').numToggle()<CR>
nnoremap <leader>nh :noh<CR>

nnoremap<leader>w :w<CR>

" easier window nav
noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-Space> <C-^>
tnoremap <C-H> <C-\><C-n><C-W><C-H>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>
tnoremap <C-Space> <C-\><C-n><C-^>

tnoremap uu <C-\><C-n>

nnoremap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>
vmap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>

nnoremap <leader>gt :silent !ctags -R <C-r>=b:projectroot<CR><CR>

vnoremap <leader>c :OSCYank<CR>

" Easier quickfix management
nnoremap <leader>cc :call ToggleQuickFix()<cr>
nmap <leader>cr <cmd>RefreshQuickFix()<CR>
nnoremap <leader>co :colder<cr>
nnoremap <leader>cn :cnewer<cr>

" Config editing/reloading
nnoremap <leader>rc <cmd>so %<CR>
nnoremap <leader>rp <cmd>PlugInstall<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>

" Reload file
nnoremap <leader>rr :e %

" Easier nav with alt
noremap <A-c> :cn<CR>
noremap <A-S-c> :cp<CR>
nnoremap <A-t> :tabnext<CR>
nnoremap <A-S-t> :tabprevious<CR>
tnoremap <A-t> <C-\><C-n>:tabnext<CR>
tnoremap <A-S-t> <C-\><C-n>:tabprevious<CR>

" Compe is really noisy for some reason
set shortmess+=c

inoremap ,, <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,; <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,: <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>
inoremap ,= <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>

" tab while using incsearch
" https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" last change pseudo-text objects
" ik ak
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>

xnoremap iN :<C-u>call VisualNumber()<CR>
onoremap iN :<C-u>normal vin<CR>

nnoremap <A-g> g;
nnoremap <A-S-g> g,
" }}}

" Imports {{{

" Keep work stuff separate
runtime ~/.config/nvim/work.vim
" }}}
