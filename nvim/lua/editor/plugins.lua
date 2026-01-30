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
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["aF"] = "@function.outer",
            ["iF"] = "@function.inner",
            ["aC"] = "@class.outer",
            ["iC"] = "@class.inner",
            ["aB"] = "@block.outer",
            ["iB"] = "@block.inner",
            ["ac"] = "@call.outer",
            ["ic"] = "@call.inner",
            ["as"] = "@statement.outer",
            ["ax"] = "@comment.outer",
            ["iN"] = "@number.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]b"] = "@block.outer",
            ["]x"] = "@comment.outer",
            ["]s"] = "@statement.outer",
            ["]N"] = "@number.inner",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]B"] = "@block.outer",
            ["]C"] = "@call.outer",
            ["][]"] = "@class.outer",
            ["]x"] = "@comment.outer",
            ["]s"] = "@statement.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[b"] = "@block.outer",
            ["[["] = "@class.outer",
            ["[x"] = "@comment.outer",
            ["[s"] = "@statement.outer",
            ["[N"] = "@number.inner",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[B"] = "@block.outer",
            ["[C"] = "@call.outer",
            ["[]"] = "@class.outer",
            ["[x"] = "@comment.outer",
            ["[s"] = "@statement.outer",
          },
        },
      },
    }
  end,
})
add({
  source = 'nvim-treesitter/nvim-treesitter-textobjects',
  depends = { 'nvim-treesitter/nvim-treesitter' },
})