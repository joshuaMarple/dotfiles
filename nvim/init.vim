" Plugins {{{
call plug#begin('~/.vim/plugged')
  " LSP
  Plug 'neovim/nvim-lspconfig'
  
  " cmp-nvim
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'williamboman/nvim-lsp-installer'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'

  " Tpope section
  Plug 'tpope/vim-surround', {'tag': 'v2.2'}
  Plug 'tpope/vim-abolish', {'tag': 'v1.1'}
  Plug 'tpope/vim-commentary', {'tag': 'v1.3'}
  Plug 'tpope/vim-unimpaired', {'tag': 'v2.0'}

  " Buffer Navigation
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'junegunn/fzf.vim', {'branch': 'master'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'joshuaMarple/vim-projectroot'

  Plug 'stefandtw/quickfix-reflector.vim', {'tag': 'v0.1'}
  Plug 'ojroques/vim-oscyank'

  " Terminal Management
  Plug 'christoomey/vim-tmux-navigator', {'tag': 'v1.0'}

  " Textobjects
  Plug 'wellle/targets.vim', {'tag' : 'v0.5.0'}

  " Themes
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'joshuaMarple/galaxyline.nvim' , {'branch': 'main'}

  " Profiling
  " Plug 'dstein64/vim-startuptime'
call plug#end() 
"}}}

" {{{ Settings
set cursorline

set foldmethod=marker

" This is in the statusline, I don't need it elsewhere
set noshowmode

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

set splitright

" Max time to wait on terminal response
set timeoutlen=1000
set ttimeoutlen=5
set updatetime=300

" Set textobj-comment
let g:textobj_comment_no_default_key_mappings = 1

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
" Easier quickfix management
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* botright cwindow
    autocmd QuickFixCmdPost l* botright lwindow
augroup END

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
augroup filechanged
  autocmd!
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

augroup UpdateProjectRoot
  autocmd!
  autocmd BufEnter * :let b:projectroot = projectroot#guess()
augroup END

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

augroup bufmarks
  autocmd!
  autocmd BufLeave *.css,*.less,*scss normal! mC
  autocmd BufLeave BUILD normal! mB
  autocmd BufLeave *.proto normal! mP
  autocmd BufLeave *.html normal! mH
  autocmd BufLeave *.java normal! mJ
  autocmd BufLeave vimrc,*.vim normal! mV
augroup END
" }}}

" Mappings {{{
""" FZF
nnoremap <leader>s :GitStat<CR>
nnoremap <leader>o :Telescope treesitter<CR>
nnoremap <leader>fp :lua require('telescope.builtin.files').find_files({search_dirs={vim.api.nvim_eval('projectroot#guess()')}})<CR>
nnoremap <leader>pt :ProfileToggle<CR>
nnoremap <leader>P :lua require'telescope'.extensions.project.project{}<CR>
nnoremap ,, :Telescope buffers<CR>
nnoremap <leader>l :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>h :Telescope oldfiles<CR>
nnoremap <leader>; :Telescope command_history<CR>
nnoremap <leader>d :Telescope help_tags<CR>
nnoremap <leader>q :Telescope quickfix<CR>
nnoremap <leader>x :Telescope commands<CR>
nnoremap <leader>g :lua require('telescope.builtin.files').live_grep({search_dirs={vim.api.nvim_eval('projectroot#guess()')}})<CR>
nnoremap <leader>G :silent grep  <C-r>=b:projectroot<CR><S-Left><Left>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>ff :Telescope file_browser<CR>
nnoremap <leader>fe :Telescope frecency<CR>
nnoremap <leader>a :Telescope lsp_code_actions<CR>

nnoremap <leader>Q <cmd>q<CR>

" Folding
" Close everything besides what I'm in
nnoremap <leader>zz zMzv

" Mapping selecting mappings
imap <c-x><c-k> <Plug>(fzf-complete-word)
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)

" I hate horizontal splitting
cabbrev h vert h

noremap <C-n> :cn<CR>
noremap <C-p> :cp<CR>

nnoremap <leader>nt :lua require('numtoggle').numToggle()<CR>
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

tnoremap ,, <C-\><C-n>:Telescope buffers<CR>
tnoremap uu <C-\><C-n>

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>

nnoremap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>
vmap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>

nnoremap gt :silent !ctags -R <C-r>=b:projectroot<CR><CR>

vnoremap <leader>c :OSCYank<CR>

" Easier quickfix management
nnoremap <leader>cc :call ToggleQuickFix()<cr>
nmap <leader>cr <cmd>RefreshQuickFix()<CR>
nnoremap <leader>cq <cmd>Telescope quickfix<CR>
nnoremap <leader>co :colder<cr>
nnoremap <leader>cn :cnewer<cr>

" Config editing/reloading
nnoremap <leader>rc <cmd>so %<CR>
nnoremap <leader>rp <cmd>PlugInstall<CR>
nnoremap <leader>ev :e $MYVIMRC<cr>

" Easier nav with alt
noremap <A-c> :cn<CR>
noremap <A-S-c> :cp<CR>
nnoremap <A-t> :tabnext<CR>
nnoremap <A-S-t> :tabprevious<CR>
tnoremap <A-t> <C-\><C-n>:tabnext<CR>
tnoremap <A-S-t> <C-\><C-n>:tabprevious<CR>

" Compe is really noisy for some reason
set shortmess+=c

" inoremap <silent><expr> <C-Space> compe#confirm('<CR>')
" inoremap <silent><expr> <C-y>     compe#confirm('<CR>')
" inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
" inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" tab while using incsearch
" https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"
" }}}

" Imports {{{
" Some files are easier to specify in lua.
lua require('config')

" Keep work stuff separate
runtime ~/.config/nvim/work.vim
" }}}
