if exists('g:profile_plug')
  finish
endif
let g:profile_plug = 1

let g:currently_profiling = 0

function! s:startProfile()
  let g:currently_profiling = 1
  profile start /tmp/profile.txt
  profile func *
  profile file *
endfunction

function! s:endProfile()
  let g:currently_profiling = 0
  profile stop
  edit /tmp/profile.txt
endfunction

function! s:toggleProfile()
  if (g:currently_profiling)
    call s:endProfile()
  else
    call s:startProfile()
  endif
endfunction

command! ProfileToggle call s:toggleProfile()
