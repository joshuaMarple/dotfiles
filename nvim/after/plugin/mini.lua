local module_checker = require('module_checker')
if not module_checker.IsModuleAvailable('mini') then
  return
end
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.jump2d').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()
require('mini.trailspace').setup()
vim.api.nvim_set_keymap(
  'n', '<CR>',
  '<Cmd>lua MiniJump2d.start()<CR>', {}
)
