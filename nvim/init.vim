call plug#begin('~/.vim/plugged') "{{
  " LSP
  Plug 'neovim/nvim-lspconfig'
  " Plug 'hrsh7th/nvim-compe'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'ludovicchabant/vim-gutentags'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Tpope section
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-unimpaired'

  " Buffer Navigation
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzy-native.nvim'
  Plug 'AckslD/nvim-neoclip.lua'
  Plug 'junegunn/fzf.vim', {'branch': 'master'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

  Plug 'dbakker/vim-projectroot'

  Plug 'mhinz/vim-startify'
  Plug 'stefandtw/quickfix-reflector.vim'
  Plug 'ojroques/vim-oscyank'

  " Terminal Management
  Plug 'kassio/neoterm'
  Plug 'voldikss/vim-floaterm'
  " Plug 'numToStr/FTerm.nvim'

  " Textobjects
  Plug 'wellle/targets.vim'
  Plug 'kana/vim-operator-user'

  " Lua
  Plug 'svermeulen/vimpeccable'

  " Themes
  Plug 'kyazdani42/nvim-web-devicons'
  " Smoothes scrolling up and down
  Plug 'https://gitlab.com/jmarple/vim-one'
  Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
call plug#end() "}}}

set cursorline

" This is in the statusline, I don't need it elsewhere
set noshowmode

" Needed for compe (https://github.com/hrsh7th/nvim-compe)
set completeopt=menuone,noselect

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

" Use nvr to edit files (prevents nesting)
let $VISUAL="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
let $FPP_EDITOR="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"

let mapleader = " "

""" FZF
nnoremap <leader>s :GitStat<CR>
nnoremap <leader>o :Telescope treesitter<CR>
" nnoremap <leader>p :ProjectFiles<CR>
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
" nnoremap <leader>g :Telescope live_grep<CR>
nnoremap <leader>g :lua require('telescope.builtin.files').live_grep({search_dirs={vim.api.nvim_eval('projectroot#guess()')}})<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>G :silent grep  <C-r>=b:projectroot<CR><S-Left><Left>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>ff :Telescope file_browser<CR>
nnoremap <leader>fr :Ranger<CR>
nnoremap <leader>fe :Telescope frecency<CR>
nnoremap <leader>H :FloatermNew htop<CR>
nnoremap <leader>a :Telescope lsp_code_actions<CR>
nnoremap <leader>v :Vista!!<CR>

nnoremap <leader>Q <cmd>q<CR>
nnoremap <leader>tr :T !!<CR>
nnoremap <leader>tv <cmd>vsplit <bar> Tnew<CR>
nnoremap <leader>tn <cmd>Tnew<CR>
nnoremap <leader>tt :Ttoggle<CR>

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

" Allows for inserting before and after text objects
nnoremap <silent> ,a :set opfunc=Append<CR>g@
nnoremap <silent> ,i :set opfunc=Insert<CR>g@

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

tnoremap ,, <C-\><C-n>:Buffers<CR>
tnoremap uu <C-\><C-n>

nnoremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>

nnoremap gs <Plug>(operator-ripgrep-root)
vnoremap gs <Plug>(operator-ripgrep-root)
call operator#user#define('ripgrep-root', 'OperatorRip', 'call SetRipOpDir(projectroot#guess())')

nnoremap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>
vmap gx :silent grep <cword> <C-r>=b:projectroot<CR><CR>

nnoremap gt :silent !ctags -R <C-r>=b:projectroot<CR><CR>

nmap g. <Plug>(operator-ripgrep-cwd)
vmap g. <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')

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

" Nvim-compe
" inoremap <silent><expr> <C-Space> compe#complete()
" Compe is really noisy for some reason
set shortmess+=c

inoremap <silent><expr> <C-Space> compe#confirm('<CR>')
inoremap <silent><expr> <C-y>     compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" tab while using incsearch
" https://www.reddit.com/r/vim/comments/4gjbqn/what_tricks_do_you_use_instead_of_popular_plugins/
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

autocmd BufLeave *.css,*.less,*scss normal! mC
autocmd BufLeave BUILD normal! mB
autocmd BufLeave *.proto normal! mP
autocmd BufLeave *.html normal! mH
autocmd BufLeave *.java normal! mJ
autocmd BufLeave term://* normal! mT
autocmd BufLeave vimrc,*.vim normal! mV
"if the file name has "test" in it, mark it T.
autocmd BufLeave *
    \ | if (expand("<afile>")) =~ ".*test.*"
    \ | execute 'normal! mT'
    \ | endif

" Some files are easier to specify in lua.
lua require('config')

" Keep work stuff separate
runtime ~/.config/nvim/work.vim
