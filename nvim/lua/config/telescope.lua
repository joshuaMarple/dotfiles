require('telescope').load_extension('fzy_native')
-- require('telescope').load_extension('neoclip')
-- require('neoclip').setup()

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
