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

" AgIn: Start ag in the specified directory
"
" e.g.
"   :AgIn .. foo
function! s:ag_in(bang, ...)
  if !isdirectory(a:1)
    throw 'not a valid directory: ' .. a:1
  endif
  " Press `?' to enable preview window.
  call fzf#vim#ag(join(a:000[1:], ' '), fzf#vim#with_preview({'dir': a:1}, 'up:50%:hidden', '?'), a:bang)

  " If you don't want preview option, use this
  " call fzf#vim#ag(join(a:000[1:], ' '), {'dir': a:1}, a:bang)
endfunction

command! -bang -nargs=+ -complete=dir AgIn call s:ag_in(<bang>0, <f-args>)
command! -bang -complete=dir AgProject call s:ag_in(<bang>0, projectroot#guess())
command! -bang -complete=dir AgProject call s:ag_in(<bang>0, projectroot#guess())


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
