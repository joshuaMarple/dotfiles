if exists('g:loaded_quickfix_toggle')
  finish
endif
let g:loaded_quickfix_toggle = 1

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        botright cwindow
    else
        cclose
    endif
endfunction
