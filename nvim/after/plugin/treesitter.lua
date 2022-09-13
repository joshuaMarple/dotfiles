if not vim.g.loaded_nvim_treesitter then
  return
end

require'nvim-treesitter.configs'.setup {
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
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]b"] = "@block.outer",
        ["]c"] = "@call.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]B"] = "@block.outer",
        ["]C"] = "@call.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[b"] = "@block.outer",
        ["[c"] = "@call.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[B"] = "@block.outer",
        ["[C"] = "@call.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}

