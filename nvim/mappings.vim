""" FZF
nnoremap <leader>s :GitFiles<CR>
nnoremap <leader>o :Bookmarks<CR>
nnoremap <leader>p :ProjectFiles<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>; :History:<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <leader>g :RgProject<CR>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Ranger<CR>
nnoremap <leader>o :CocFzfList outline<CR>
" nnoremap <leader>r :Ranger<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" I hate horizontal help
cabbrev h vert h

" NERDTree
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>nt :call NumToggle()<CR>
nnoremap <leader>nh :noh<CR>

let g:swap_no_default_key_mappings = 1
map g< <Plug>(swap-prev)
map g> <Plug>(swap-next)

""" EasyMotion
nmap s <Plug>(easymotion-overwin-f2)

" COC
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rr :Ranger<CR>

" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

" better key bindings for UltiSnipsExpandTrigger

map z/ <Plug>(incsearch-easymotion-/)

" incsearch.vim x fuzzy x vim-easymotion

nmap<leader>w :w<CR>

nnoremap <silent> ,a :set opfunc=Append<CR>g@
nnoremap <silent> ,i :set opfunc=Insert<CR>g@
" nnoremap <silent> ,m :set opfunc=Insert<CR><ESC>g@
" nnoremap <silent> ,n :set opfunc=Append<CR><ESC>g@

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap ;; ;
nnoremap ; :
vnoremap ; :

" noremap <C-H> <C-W><C-H>
" noremap <C-N> <C-W><C-J>
" noremap <C-E> <C-W><C-K>
" noremap <C-I> <C-W><C-L>

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)


let g:textobj_comment_no_default_key_mappings = 1
xmap ax <Plug>(textobj-comment-a)
omap ax <Plug>(textobj-comment-a)
xmap ix <Plug>(textobj-comment-i)
omap ix <Plug>(textobj-comment-i)
xmap aX <Plug>(textobj-big-a)
omap aX <Plug>(textobj-big-a)
xmap iX <Plug>(textobj-big-i)
omap iX <Plug>(textobj-big-a)

inoremap uu <Esc>
vnoremap uu <Esc>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap uu <Esc>
  " au FileType fzf tunmap <Esc>
endif

nnoremap <silent> <leader>t :FloatermToggle<CR>
function! RootRelativeToCwd()
  if getcwd() == projectroot#guess()
    return '.'
  endif

  let relative = split(getcwd(), b:projectroot_name . '/')
  if len(relative) == 0
    return b:projectroot_name
  else
    let relative = relative[1]
  endif

  let path = ''
  for part in split(relative, '/')
    let path .= '../'
  endfor

  return path
endfunction

augroup AssignProjectRoot
  au!
  au BufRead,BufNew * let b:projectroot = projectroot#guess() | let b:projectroot_name = matchstr(b:projectroot, '/\zs[^\/]\+\ze$')
augroup END

" tnoremap <silent> <C-e> <C-\><C-n>:FloatermToggle<CR>
nmap gs <Plug>(operator-ripgrep-root)
vmap gs <Plug>(operator-ripgrep-root)
call operator#user#define('ripgrep-root', 'OperatorRip', 'call SetRipOpDir(RootRelativeToCwd())')

nmap gS <Plug>(operator-ripgrep-rel)
vmap gS <Plug>(operator-ripgrep-rel)
call operator#user#define('ripgrep-rel', 'OperatorRip', 'call SetRipOpDir(expand("%:h"))')

nmap g. <Plug>(operator-ripgrep-cwd)
vmap g. <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')


vnoremap <leader>c :OSCYank<CR>


