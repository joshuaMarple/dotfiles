require('mini.comment').setup()
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.jump2d').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()
vim.api.nvim_set_keymap(
  'n', '<CR>',
  '<Cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.query)<CR>', {}
)
