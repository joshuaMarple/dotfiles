" Issues with typescript being recognized as XML
" (https://github.com/leafgarland/typescript-vim/issues/96)
augroup ts
  autocmd!
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
augroup END
