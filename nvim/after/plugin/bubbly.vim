lua << EOF
vim.g.bubbly_statusline = {
  'mode',

  'truncate',

  'path',
  'signify',

  'divisor',
  'builtinlsp.current_function',

  'filetype',
  'progress',
}
EOF
