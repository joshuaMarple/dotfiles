setlocal nonumber norelativenumber

" set g:neoterm_keep_term_open=true

" Terminal should automatically go into insert mode
augroup terminsert
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

