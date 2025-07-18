-- UI-related keymaps
local map = vim.keymap.set

-- No highlight
map('n', '<leader>nh', ':noh<CR>')

-- Window nav
map({ 'n', 't' }, '<C-H>', '<C-W><C-H>')
map({ 'n', 't' }, '<C-J>', '<C-W><C-J>')
map({ 'n', 't' }, '<C-K>', '<C-W><C-K>')
map({ 'n', 't' }, '<C-L>', '<C-W><C-L>')
map('n', '<C-Space>', '<C-^>')
map('t', 'uu', '<C-\\><C-n>')

-- SynStack for syntax debugging
_G.SynStack = function()
  if vim.fn.exists("*synstack") == 0 then
    return
  end
  print(vim.inspect(vim.fn.map(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.')), 'synIDattr(v:val, "name")')))
end
map('n', '<leader>ccs', ':lua _G.SynStack()<CR>')