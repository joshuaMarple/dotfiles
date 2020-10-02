""" FZF
nnoremap <leader>s :GitStat<CR>
nnoremap <leader>o :Bookmarks<CR>
nnoremap <leader>p :ProjectFiles<CR>
nnoremap , :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>; :History:<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <leader>g :Ag<CR>
nnoremap <leader>e :Vexplore<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>f :Files<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" I hate horizontal help
cabbrev h vert h

" NERDTree
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>nt :call NumToggle()<CR>

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
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" better key bindings for UltiSnipsExpandTrigger

map z/ <Plug>(incsearch-easymotion-/)

" incsearch.vim x fuzzy x vim-easymotion

nmap<leader>w :w<CR>

nnoremap <silent> <Leader>a :set opfunc=Append<CR>g@
nnoremap <silent> <Leader>i :set opfunc=Insert<CR>g@

nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
nnoremap ;; ;
nnoremap ; :
vnoremap ; :

map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  au FileType fzf tunmap <Esc>
endif

nnoremap <silent> <leader>t :FloatermToggle<CR>

" tnoremap <silent> <C-e> <C-\><C-n>:FloatermToggle<CR>
