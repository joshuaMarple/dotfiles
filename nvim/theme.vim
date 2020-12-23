" https://github.com/joshdick/onedark.vim
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

syntax on
set background=light
colorscheme one
hi Normal guibg=NONE ctermbg=NONE
" let g:lightline = {
"   \ 'colorscheme': 'one',
"   \ }

" Issues with typescript being recognized as XML
" (https://github.com/leafgarland/typescript-vim/issues/96)
autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

" vim.g.bubbly_palette = {
"    background = "White",
"    foreground = "White",
"    black = "Black",
"    red = "Red",
"    green = "Green",
"    yellow = "Yellow",
"    blue = "Blue",
"    purple = "Magenta",
"    cyan = "Cyan",
"    white = "White",
"    lightgrey = "LightGrey",
"    darkgrey = "Grey",
" }
let g:bubbly_palette = #{
\   background: "#fafafa",
\   foreground: "#c5cdd9",
\   black: "#3e4249",
\   red: "#ec7279",
\   green: "#a0c980",
\   yellow: "#deb974",
\   blue: "#6cb6eb",
\   purple: "#d38aea",
\   cyan: "#5dbbc1",
\   white: "#c5cdd9",
\   lightgrey: "#57595e",
\   darkgrey: "#404247",
\ }
