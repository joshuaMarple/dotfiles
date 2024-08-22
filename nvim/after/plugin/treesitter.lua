if not vim.g.loaded_nvim_treesitter then
  return
end

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
        -- You can use the capture groups defined in textobjects.scm
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
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]b"] = "@block.outer",
        -- ["]c"] = "@call.outer",
        ["]x"] = "@comment.outer",
        ["]s"] = "@statement.outer",
        ["]N"] = "@number.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]B"] = "@block.outer",
        ["]C"] = "@call.outer",
        ["]["] = "@class.outer",
        ["]x"] = "@comment.outer",
        ["]s"] = "@statement.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[b"] = "@block.outer",
        -- ["[c"] = "@call.outer",
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
--
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.foldtext =
--     [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]
-- vim.wo.fillchars = "fold:\\"
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
