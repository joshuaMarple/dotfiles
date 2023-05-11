local module_checker = require('module_checker')
if not module_checker.IsModuleAvailable('mini') then
  return
end
require('mini.comment').setup()
-- require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()
require('mini.trailspace').setup()
require('mini.surround').setup()
-- require('mini.statusline').setup()
require('mini.animate').setup()
local starter = require('mini.starter')
starter.setup()
