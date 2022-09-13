if not vim.g.loaded_telescope then
  return
end

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
}
