-- System integration keymaps
local map = vim.keymap.set

-- Quickfix nav
map({ 'n', 'v' }, '<C-n>', ':cn<CR>')
map({ 'n', 'v' }, '<C-p>', ':cp<CR>')

-- Alt quickfix nav
map({ 'n', 'i', 'v', 't' }, '<A-c>', ':cn<CR>')
map({ 'n', 'i', 'v', 't' }, '<A-S-c>', ':cp<CR>')

-- Quickfix management
map('n', '<leader>cc', function() require('system.quickfix').toggle_quickfix() end)
map('n', '<leader>cr', function() require('system.quickfix').refresh_quickfix() end)
map('n', '<leader>co', ':colder<CR>')
map('n', '<leader>cn', ':cnewer<CR>')

-- Profile
map('n', '<leader>pt', ':ProfileToggle<CR>')

-- Alt nav
map({ 'n', 't' }, '<A-t>', ':tabnext<CR>')
map({ 'n', 't' }, '<A-S-t>', ':tabprevious<CR>')

-- OSCYank
vim.g.oscyank_term = 'default'
map('v', '<leader>c', ':OSCYank<CR>')