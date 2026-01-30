-- Text editing, objects and enhancement plugins
local add = require('mini.deps').add

-- Text objects and editing enhancements
add({
  source = 'chrisgrieser/nvim-various-textobjs',
  config = function()
    require("various-textobjs").setup {}
  end
})
add('joshuaMarple/vim-abolish')
add('joshuaMarple/vim-unimpaired')
add('ColinKennedy/cursor-text-objects.nvim')

-- File management
add('joshuaMarple/undotree')

-- Other editing tools
add({
  source = 'cshuaimin/ssr.nvim',
  config = function()
    vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
  end,
})

-- Treesitter
add({
  source = 'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },
      highlight = {
        enable = true,
      },
    }
  end,
})

