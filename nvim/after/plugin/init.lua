local module_checker = require('module_checker')
if vim.g.loaded_devicons and vim.g.loaded_galaxyline then
  require('dotline')
end

if module_checker.IsModuleAvailable('ssr') then
  vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
end


-- require('avante_lib').load()
-- require('avante').setup({
--   provider='gemini'
--
-- })

-- require('blink').setup({
--
-- })
