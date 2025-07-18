local M = {}

-- Visual number selection functionality
function M.select_number()
  local current_line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  
  -- Find start of number
  local start_col = col
  while start_col > 0 do
    local char = current_line:sub(start_col, start_col)
    if not char:match('[%d%.]') then
      start_col = start_col + 1
      break
    end
    start_col = start_col - 1
  end
  
  -- Find end of number
  local end_col = col + 1
  while end_col <= #current_line do
    local char = current_line:sub(end_col, end_col)
    if not char:match('[%d%.]') then
      end_col = end_col - 1
      break
    end
    end_col = end_col + 1
  end
  
  -- Select the number
  vim.api.nvim_win_set_cursor(0, {vim.api.nvim_win_get_cursor(0)[1], start_col - 1})
  vim.cmd('normal! v')
  vim.api.nvim_win_set_cursor(0, {vim.api.nvim_win_get_cursor(0)[1], end_col - 1})
end

return M