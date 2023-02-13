local m = require('mapping')
if not vim.g.loaded_undotree then
  return
end

m.nmap('<leader>ut', "<CMD>:UndotreeToggle<CR>")
m.nmap('<leader>uf', "<CMD>:UndotreeFocus<CR>")
