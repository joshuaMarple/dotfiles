-- LSP-related keymaps
local map = vim.keymap.set

-- LSP code actions via Telescope
map('n', '<leader>ca', '<CMD>Telescope lsp_code_actions<CR>')