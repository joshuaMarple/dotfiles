-- Text editing and object keymaps
local map = vim.keymap.set

-- last change pseudo-text objects
map('x', 'ik', '`]o`[')
map('o', 'ik', ':<C-u>normal vik<CR>')
map('o', 'ak', ':<C-u>normal vikV<CR>')

map('x', 'iN', function() require('editor.text-objects').select_number() end)
map('o', 'iN', ':<C-u>normal viN<CR>')

-- Text object comment mappings
vim.g.textobj_comment_no_default_key_mappings = 1
map('x', 'ax', '<Plug>(textobj-comment-a)')
map('o', 'ax', '<Plug>(textobj-comment-a)')
map('x', 'ix', '<Plug>(textobj-comment-i)')
map('o', 'ix', '<Plug>(textobj-comment-i)')
map('x', 'aX', '<Plug>(textobj-big-a)')
map('o', 'aX', '<Plug>(textobj-big-a)')
map('x', 'iX', '<Plug>(textobj-big-i)')
map('o', 'iX', '<Plug>(textobj-big-a)')

-- Folding
map('n', '<leader>zz', 'zMzv')

-- Reload file
map('n', '<leader>rr', ':e %<CR>')
map('n', '<leader>Rr', ':e! %<CR>')

-- Jump list nav
map('n', '<A-g>', 'g;')
map('n', '<A-S-g>', 'g,')

-- Undotree
map('n', '<leader>ut', "<CMD>:UndotreeToggle<CR>")
map('n', '<leader>uf', "<CMD>:UndotreeFocus<CR>")