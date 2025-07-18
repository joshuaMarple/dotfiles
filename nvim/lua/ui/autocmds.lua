-- UI-related autocommands
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes
local autoresize_group = group('autoresize', { clear = true })
autocmd('VimResized', {
  group = autoresize_group,
  pattern = '*',
  command = 'wincmd =',
})