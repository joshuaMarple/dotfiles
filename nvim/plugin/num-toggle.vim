if exists('g:loaded_num_toggle')
  finish
endif
let g:loaded_num_toggle = 1

""" Flip numline to opposite of current status
function NumToggle()
  set rnu!
  set nu!
endfunction
