if exists('g:loaded_visual_number')
  finish
endif
let g:loaded_visual_number = 1
u

function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
