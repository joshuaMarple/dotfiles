autocmd BufNewFile,BufEnter * silent! lcd %:p:h

set history=10000

set nu
set rnu
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
set autoindent

let g:netrw_banner=0

" Ignore case when searching
set ignorecase

let g:rooter_silent_chdir = 1

" When searching try to be smart about cases
set smartcase

" Highlight search results
"set hlsearch
let g:incsearch#auto_nohlsearch = 1

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

set timeoutlen=1000
set ttimeoutlen=5

let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:ascii = ['']

let g:startify_custom_header = g:ascii

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

""" COC
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" https://superuser.com/questions/181377/auto-reloading-a-file-in-vim-as-soon-as-it-changes-on-disk
set autoread
"au CursorHold * checktime

let g:wordmotion_prefix = 'm'

" Smart pairs are disabled by default:
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:rooter_manual_only = 1
let mapleader = " "

augroup TerminalStuff
  au!
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
