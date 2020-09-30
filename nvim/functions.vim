""" Get list of bookmarks (https://github.com/urbainvaes/fzf-marks)
command! Bookmarks call fzf#run(fzf#wrap({'source': 'cut -d: -f 2 ~/.fzf-marks | awk ''{$1=$1};1'''}))

""" Hg status in FZF
command! HgPstat call fzf#run(fzf#wrap({'source': 'hg pstatus -n'}))

""" Git status in FZF
command! GitStat call fzf#run(fzf#wrap({'source': 'git status -s | cut -c4-'}))

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

command! ProjectFiles execute 'Files' FindRootDirectory()

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

