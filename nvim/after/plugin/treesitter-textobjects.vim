lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["aC"] = "@class.outer",
        ["iC"] = "@class.inner",
        ["aB"] = "@block.outer",
        ["iB"] = "@block.inner",
        ["aA"] = "@parameter.outer",
        ["iA"] = "@parameter.inner",
        ["aL"] = "@loop.outer",
        ["iL"] = "@loop.inner",
        ["aM"] = "@call.outer",
        ["iM"] = "@call.inner",
        ["iS"] = "@statement.outer",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        -- ["]c"] = "@conditional.outer",
        ["]a"] = "@parameter.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        -- ["]C"] = "@conditional.outer",
        ["]A"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        -- ["[c"] = "@conditional.outer",
        ["[a"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        -- ["[C"] = "@conditional.outer",
        ["[A"] = "@parameter.outer",
      },
    },
  },
}
EOF
