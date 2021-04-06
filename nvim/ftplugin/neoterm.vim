setlocal nonumber norelativenumber

" Terminal should automatically go into insert mode
augroup terminsert
  autocmd!
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END

