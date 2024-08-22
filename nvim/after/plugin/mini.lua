local module_checker = require('module_checker')
if not module_checker.IsModuleAvailable('mini') then
  return
end
require('mini.comment').setup()
require('mini.bracketed').setup()
-- require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()
require('mini.trailspace').setup()
require('mini.surround').setup()
-- require('mini.statusline').setup()
require('mini.animate').setup()
require('mini.completion').setup()
local starter = require('mini.starter')
starter.setup({
    items = {
      starter.sections.telescope(),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
