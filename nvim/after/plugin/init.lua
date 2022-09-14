local module_checker = require('module_checker')
if vim.g.loaded_devicons and vim.g.loaded_galaxyline then
  require('dotline')
end

if module_checker.IsModuleAvailable('leap') then
  require('leap').set_default_keymaps()
end
