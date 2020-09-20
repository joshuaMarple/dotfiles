""" Get list of bookmarks (https://github.com/urbainvaes/fzf-marks)
command! Bookmarks call fzf#run(fzf#wrap({'source': 'cut -d: -f 2 ~/.fzf-marks | awk ''{$1=$1};1'''}))

""" Hg status in FZF
command! HgPstat call fzf#run(fzf#wrap({'source': 'hg pstatus -n'}))

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(30)
  let width = float2nr(120)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
    \ 'relative': 'editor'
    \ 'row': vertical
    \ 'col': horizontal
    \ 'width': width
    \ 'height': height
    \ 'style': 'minimal'
    \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

""" Flip numline to opposite of current status
function NumToggle()
  set rnu!
  set nu!
endfunction
