" https://github.com/joshdick/onedark.vim
if (has("nvim"))
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
	set termguicolors
endif

"let g:airline_powerline_fonts = 1

syntax on
set background=light
colorscheme	one
let g:lightline = {
  \ 'colorscheme': 'one',
  \ }

" Issues with typescript being recognized as XML
" (https://github.com/leafgarland/typescript-vim/issues/96)
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
