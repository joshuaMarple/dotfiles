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

command! -bang -nargs=* Rip :call s:CallRipGrep(<bang>1, projectroot#guess(), <f-args>)
command! -bang -nargs=* Ripcwd :call s:CallRipGrep(<bang>1, getcwd(), <f-args>)
command! -bang -nargs=* Ripfile :call s:CallRipGrep(<bang>1, expand("%:h"), <f-args>)
