local m = require('mapping')

if not vim.g.loaded_telescope then
  return
end

m.nmap('<leader>s', '<CMD>Telescope git_status<CR>')
m.nmap('<leader>o', '<CMD>Telescope treesitter<CR>')
m.nmap('<leader>fp', "<CMD>lua require('project_telescope').project_find_files()<CR>")
m.nmap(',,', '<CMD>Telescope buffers<CR>')
m.nmap('<leader>b', '<CMD>Telescope buffers<CR>')
m.nmap('<leader>gp', "<CMD>lua require('project_telescope').project_grep()<CR>")
m.nmap('<leader>gg', '<CMD>Telescope live_grep<CR>')
m.nmap('<leader>gb', "<CMD>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>")
m.nmap('<leader>l', '<CMD>Telescope current_buffer_fuzzy_find<CR>')
m.nmap('<leader>h', '<CMD>Telescope oldfiles<CR>')
m.nmap('<leader>;', '<CMD>Telescope command_history<CR>')
m.nmap('<leader>d', '<CMD>Telescope help_tags<CR>')
m.nmap('<leader>q', '<CMD>Telescope quickfix<CR>')
m.nmap('<leader>x', '<CMD>Telescope commands<CR>')
m.nmap('<leader>ff', '<CMD>Telescope file_browser<CR>')
m.nmap('<leader>a', '<CMD>Telescope lsp_code_actions<CR>')
m.nmap('<leader>tr', '<CMD>Telescope resume<CR>')

require("telescope").load_extension "file_browser"

require('telescope').setup{
  -- Sharp borders are better
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
      ast_grep = {
          command = {
              "sg",
              "--json=stream",
          }, -- must have --json=stream
          grep_open_files = false, -- search in opened files
          lang = nil, -- string value, specify language for ast-grep `nil` for default
    }
  }
}
