-- Telescope and file management plugins
local add = require('mini.deps').add

-- Telescope
add('nvim-lua/plenary.nvim')
add({
  source = 'nvim-telescope/telescope.nvim',
  checkout = '0.1.8',
  config = function()
    require('telescope').setup{
      defaults = {
       borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
       layout_strategy = "vertical",
       layout_config = {
          vertical = {
            width_padding = 0.05,
            height_padding = 1,
            preview_height = 0.5,
            mirror = false,
          }
       }
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        },
          ast_grep = {
              command = { "sg", "--json=stream" },
              grep_open_files = false,
              lang = nil,
        }
      }
    }
    require("telescope").load_extension("ui-select")
  end
})
add('nvim-telescope/telescope-ui-select.nvim')
add('Marskey/telescope-sg')
add({
  source = 'nvim-telescope/telescope-file-browser.nvim',
  config = function()
    require("telescope").load_extension("file_browser")
  end
})