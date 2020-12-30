""" Get list of bookmarks (https://github.com/urbainvaes/fzf-marks)
command! Bookmarks call fzf#run(fzf#wrap({'source': 'cut -d: -f 2 ~/.fzf-marks | awk ''{$1=$1};1'''}))

""" Hg status in FZF
command! HgPstat call fzf#run(fzf#wrap({'source': 'hg pstatus -n'}))

""" Git status in FZF
command! GitStat call fzf#run(fzf#wrap({'source': 'git status -s | cut -c4-'}))

command! Ranger FloatermNew ranger

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(30)
  let width = float2nr(200)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
    \ 'relative': 'editor',
    \ 'row': vertical,
    \ 'col': horizontal,
    \ 'width': width,
    \ 'height': height,
    \ 'style': 'minimal'
    \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

""" Flip numline to opposite of current status
function NumToggle()
  set rnu!
  set nu!
endfunction

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

function! Append(type, ...)
    normal! `]
    if a:type == 'char'
        call feedkeys("a", 'n')
    else
        call feedkeys("o", 'n')
    endif
endfunction

function! Insert(type, ...)
    normal! `[
    if a:type == 'char'
        call feedkeys("i", 'n')
    else
        call feedkeys("O", 'n')
    endif
endfunction

command! ProjectFiles execute 'Files' projectroot#guess()
" command! ProjectAg call fzf#vim#ag_in('', {'': FindRootDirectory()})
command! GitDiff FloatermNew git diff

command! -bang -nargs=* PGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let s:actions = {
  \   'ctrl-t': 'tabe',
  \   'ctrl-x': 'split',
  \   'ctrl-v': 'vsplit'
  \ }

let s:base_rip = 'rg --column --line-number --no-heading --hidden --follow --color "never"'

function! s:CallRipGrep(smartcase, where, ...) abort
  let args = copy(a:000)
  let flags = []
  let terms = []

  let cmd = s:base_rip

  if a:smartcase
    let cmd .= ' --smart-case '
  endif

  for arg in args
    if match(arg, '^-') == 0
      call add(flags, arg)
    else
      call add(terms, arg)
    endif
  endfor

  let where = a:where

  if where == ''
    let where = remove(terms, -1)
  endif

  let term = join(terms, ' ')
  let term = '"' . term . '"'

  if len(flags)
    let cmd .= join(flags, ' ') . ' '
  endif

  let cmd .= term  . ' ' . where
  call fzf#vim#grep(cmd, 1, { 'options': '--expect='. join(keys(s:actions), ',') })
endfunction

function! s:RipWithRange(smartcase, where) range
  let lines = join(getline(a:firstline, a:lastline), '\n')
  call s:CallRipGrep(a:smartcase, a:where, lines)
endfunction

function! SetRipOpDir(dir) abort
  let s:rip_opt_dir = a:dir
endfunction

function! OperatorRip(wiseness) abort
  if a:wiseness ==# 'char'
    normal! `[v`]"ay
    call s:CallRipGrep(1, s:rip_opt_dir, @a)
  elseif a:wiseness ==# 'line'
    '[,']call s:RipWithRange(1, s:rip_opt_dir)
  endif
endfunction

nmap gr <Plug>(operator-ripgrep-root)
vmap gr <Plug>(operator-ripgrep-root)
call operator#user#define('ripgrep-root', 'OperatorRip', 'call SetRipOpDir(RootRelativeToCwd())')

nmap gR <Plug>(operator-ripgrep-rel)
vmap gR <Plug>(operator-ripgrep-rel)
call operator#user#define('ripgrep-rel', 'OperatorRip', 'call SetRipOpDir(expand("%:h"))')

nmap g. <Plug>(operator-ripgrep-cwd)
vmap g. <Plug>(operator-ripgrep-cwd)
call operator#user#define('ripgrep-cwd', 'OperatorRip', 'call SetRipOpDir(getcwd())')

command! -bang -nargs=* Rip :call s:CallRipGrep(<bang>1, RootRelativeToCwd(), <f-args>)
command! -bang -nargs=* Ripcwd :call s:CallRipGrep(<bang>1, getcwd(), <f-args>)
command! -bang -nargs=* Ripfile :call s:CallRipGrep(<bang>1, expand("%:h"), <f-args>)

function! GoToDefinition()
  if CocAction('jumpDefinition')
    return v:true
  endif

  let ret = execute("silent! normal \<C-]>")
  if ret =~ "Error"
    call searchdecl(expand('<cword>'))
  endif
endfunction

function! ProjectDo(command)
  ProjectRootExe args **/*
  execute 'argdo ' . a:command
endfunction

function! BufClear()
  bufdo e!
endfunction

function! s:DiffAll()
  bufdo echo expand('%:p') | w !diff % -
endfunction
com! DiffAll call s:DiffAll()

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

command! -nargs=+ -complete=command ProjectDo call ProjectDo(<q-args>)

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
