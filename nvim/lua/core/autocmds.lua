-- Core system autocommands
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Notification after file change
local filechanged_group = group('filechanged', { clear = true })
autocmd('FileChangedShellPost', {
  group = filechanged_group,
  pattern = '*',
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.', vim.log.levels.WARN)
  end,
})