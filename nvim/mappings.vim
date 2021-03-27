""" FZF
nnoremap <leader>s :GitStat<CR>
nnoremap <leader>o :Bookmarks<CR>
nnoremap <leader>p :ProjectFiles<CR>
nnoremap ,, :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>; :History:<CR>
nnoremap <leader>d :Helptags<CR>
nnoremap <leader>x :Commands<CR>
nnoremap <leader>g :Rip<CR>
nnoremap <leader>e :Vexplore<CR>
" nnoremap <leader>q :q<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Ranger<CR>
nnoremap <leader>o :CocFzfList outline<CR>
" nnoremap <leader>r :Ranger<CR>

nnoremap <leader>Q <cmd>q<CR>
nnoremap <leader>tr :T !!<CR>
nnoremap <leader>tn <cmd>vsplit <bar> Tnew<CR>
nnoremap <leader>tt :Ttoggle<CR>
" Mapping selecting mappings
nmap <leader><tab> <Plug>(fzf-maps-n)
xmap <leader><tab> <Plug>(fzf-maps-x)
omap <leader><tab> <Plug>(fzf-maps-o)
imap <c-x><c-k> <Plug>(fzf-complete-word)
imap <c-x><c-f> <Plug>(fzf-complete-path)
imap <c-x><c-l> <Plug>(fzf-complete-line)

" I hate horizontal help
cabbrev h vert h

map <C-n> :cn<CR>
map <C-p> :cp<CR>

nnoremap <leader>nt :call NumToggletest()<CR>
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

nmap <silent> gd :call GoToDefinition()<CR>
" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
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

noremap <C-H> <C-W><C-H>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-<Left>> <C-W><C-H>
noremap <C-<Down>> <C-W><C-J>
noremap <C-<Up>> <C-W><C-K>
noremap <C-<Right>> <C-W><C-L>

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

autocmd BufWinEnter,WinEnter term://* startinsert

if has('nvim')
  tnoremap ,, <C-\><C-n>:Buffers<CR>
  tnoremap <C-H> <C-\><C-n><C-W><C-H>
  tnoremap <C-J> <C-\><C-n><C-W><C-J>
  tnoremap <C-K> <C-\><C-n><C-W><C-K>
  tnoremap <C-L> <C-\><C-n><C-W><C-L>
  tnoremap <C-<Left>> <C-\><C-n><C-W><C-H>
  tnoremap <C-<Down>> <C-\><C-n><C-W><C-J>
  tnoremap <C-<Up>> <C-\><C-n><C-W><C-K>
  tnoremap <C-<Right>> <C-\><C-n><C-W><C-L>
  " tnoremap <Esc> <C-\><C-n>
  tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
  tnoremap uu <C-\><C-n>
  " au FileType fzf tunmap <Esc>
endif

nnoremap <silent> <C-t> :FloatermToggle<CR>
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

nmap gx <cmd>Rg<CR>
vmap gx <cmd>Rg<CR>

nmap gS <Plug>(operator-ripgrep-rel)
vmap gS <Plug>(operator-ripgrep-rel)
call operator#user#define('ripgrep-rel', 'OperatorRip', 'call SetRipOpDir(expand("%:h"))')

nmap g. <Plug>(operator-ripgrep-cwd)
vmap g. <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')


vnoremap <leader>c :OSCYank<CR>

nmap ,s <plug>(SubversiveSubstituteRange)
xmap ,s <plug>(SubversiveSubstituteRange)
nmap ,ss <plug>(SubversiveSubstituteWordRange)

nmap ,S <plug>(SubversiveSubvertRange)
xmap ,S <plug>(SubversiveSubvertRange)
nmap ,Ss <plug>(SubversiveSubvertWordRange)

nmap <leader>qs <Plug>(qf_qf_switch)
nmap <leader>qt <Plug>(qf_qf_toggle)
nmap <leader>qr <cmd>RefreshQuickFix()<CR>
nmap <leader>qq <cmd>Telescope quickfix<CR>

nmap <leader>rc <cmd>so %<CR>
nmap <leader>rp <cmd>PlugInstall<CR>

vmap <leader>vs <cmd>VSSplitAbove<CR>
let g:textobj_wordcolumn_no_default_key_mappings = 1

call textobj#user#map('wordcolumn', {
            \ 'word' : {
            \   'select-i' : 'io',
            \   'select-a' : 'ao',
            \   },
            \ 'WORD' : {
            \   'select-i' : 'iO',
            \   'select-a' : 'aO',
            \   },
            \ })

nnoremap <leader>ev :vsplit $MYVIMRC<cr>

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aB"] = "@block.outer",
        ["iB"] = "@block.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["aL"] = "@loop.outer",
        ["iL"] = "@loop.inner",
        ["aM"] = "@call.outer",
        ["iM"] = "@call.inner",
        ["iS"] = "@statement.outer",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]c"] = "@conditional.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]C"] = "@conditional.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[c"] = "@conditional.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[C"] = "@conditional.outer",
      },
    },
  },
}
EOF
