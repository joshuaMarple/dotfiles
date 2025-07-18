-- Core functionality keymaps
local map = vim.keymap.set

-- Quit
map('n', '<leader>Q', '<cmd>q<CR>')

-- Vanilla Key Bindings (fallbacks)
map('n', '<leader>D', ':help ')

-- Write
map('n', '<leader>w', ':w<CR>')

-- Config editing/reloading
map('n', '<leader>rc', '<cmd>so $MYVIMRC<CR>')
map('n', '<leader>rp', function() require('mini.deps').update() end, { desc = "Update plugins" })
map('n', '<leader>ev', ':e $MYVIMRC<cr>')