local M = {}

-- QuickFix toggle functionality
function M.toggle_quickfix()
  local windows = vim.fn.getwininfo()
  local qf_exists = false
  for _, win in pairs(windows) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end
  
  if qf_exists then
    vim.cmd('cclose')
  else
    vim.cmd('botright cwindow')
  end
end

-- Refresh QuickFix functionality
function M.refresh_quickfix()
  local qflist = vim.fn.getqflist()
  for _, item in ipairs(qflist) do
    if item.bufnr and item.lnum then
      local lines = vim.api.nvim_buf_get_lines(item.bufnr, item.lnum - 1, item.lnum, false)
      if lines[1] then
        item.text = lines[1]
      end
    end
  end
  vim.fn.setqflist(qflist)
end


return M