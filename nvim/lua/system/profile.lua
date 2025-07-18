-- Neovim profiling functionality
local M = {}

local currently_profiling = false

local function start_profile()
  currently_profiling = true
  vim.cmd('profile start /tmp/profile.txt')
  vim.cmd('profile func *')
  vim.cmd('profile file *')
end

local function end_profile()
  currently_profiling = false
  vim.cmd('profile stop')
  vim.cmd('edit /tmp/profile.txt')
end

function M.toggle_profile()
  if currently_profiling then
    end_profile()
  else
    start_profile()
  end
end

-- Create command
vim.api.nvim_create_user_command('ProfileToggle', M.toggle_profile, {})

return M