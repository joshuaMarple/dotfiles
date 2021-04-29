if exists('g:loaded_refresh_quickfix')
  finish
endif
let g:loaded_refresh_quickfix = 1

function! RefreshQuickFix()
  call setqflist(map(getqflist(), 'extend(v:val, {"text":get(getbufline(v:val.bufnr, v:val.lnum),0)})'))
endfunction

