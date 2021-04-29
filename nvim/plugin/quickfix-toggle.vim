if exists('g:quickfix_toggle')
  finish
endif
let g:loaded_fzf_helpers = 1

function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        botright cwindow
    else
        cclose
    endif
endfunction
