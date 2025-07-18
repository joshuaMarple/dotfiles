-- File management and search keymaps
local map = vim.keymap.set

-- Grep using project root
map('n', 'gx', ':silent grep <cword> <C-r>=b:projectroot<CR><CR>')
map('v', 'gx', ':silent grep <cword> <C-r>=b:projectroot<CR><CR>')

-- Ctags
map('n', '<leader>gt', ':silent !ctags -R <C-r>=b:projectroot<CR><CR>')

-- Incsearch tab
vim.keymap.set('c', '<Tab>', function()
  if vim.fn.getcmdtype() == '/' or vim.fn.getcmdtype() == '?' then
    return '<CR>/<C-r>/'
  else
    return '<C-z>'
  end
end, { expr = true })

vim.keymap.set('c', '<S-Tab>', function()
  if vim.fn.getcmdtype() == '/' or vim.fn.getcmdtype() == '?' then
    return '<CR>?<C-r>/'
  else
    return '<S-Tab>'
  end
end, { expr = true })

-- Telescope mappings
map('n', '<leader>s', '<CMD>Telescope git_status<CR>')
map('n', '<leader>o', '<CMD>Telescope treesitter<CR>')
map('n', '<leader>fp', "<CMD>lua require('files.project_telescope').project_find_files()<CR>")
map('n', ',,', '<CMD>Telescope buffers<CR>')
map('n', '<leader>b', '<CMD>Telescope buffers<CR>')
map('n', '<leader>gp', "<CMD>lua require('files.project_telescope').project_grep()<CR>")
map('n', '<leader>gg', '<CMD>Telescope live_grep<CR>')
map('n', '<leader>gb', "<CMD>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
map('n', '<leader>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')
map('n', '<leader>h', '<CMD>Telescope oldfiles<CR>')
map('n', '<leader>;', '<CMD>Telescope command_history<CR>')
map('n', '<leader>d', '<CMD>Telescope help_tags<CR>')
map('n', '<leader>q', '<CMD>Telescope quickfix<CR>')
map('n', '<leader>x', '<CMD>Telescope commands<CR>')
map('n', '<leader>ff', '<CMD>Telescope file_browser<CR>')
map('n', '<leader>tr', '<CMD>Telescope resume<CR>')