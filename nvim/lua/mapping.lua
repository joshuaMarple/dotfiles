local mapping = {}

local opts = { noremap=true, silent=true }

function mapping.nmap(map, binding)
  vim.api.nvim_set_keymap('n', map, binding, opts)
end

function mapping.xmap(map, binding)
  vim.api.nvim_set_keymap('x', map, binding, opts)
end

return mapping
