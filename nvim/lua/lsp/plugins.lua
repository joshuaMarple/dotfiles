-- LSP and Language Server related plugins
local add = require('mini.deps').add

-- LSP
add('neovim/nvim-lspconfig')
add('williamboman/mason.nvim')
add({
  source = 'williamboman/mason-lspconfig.nvim',
  config = function()
    require('lsp.config').setup()
  end
})