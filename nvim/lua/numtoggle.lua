local function num_toggle()
  vim.wo.number = not vim.wo.number
end

return {
  numToggle = num_toggle
}
