if !exists('g:loaded_startify')
  finish
endif

" I'm not creative with ascii art
let g:startify_custom_header = ['']
augroup startified
  autocmd!
  autocmd User Startified setlocal buflisted
augroup END

