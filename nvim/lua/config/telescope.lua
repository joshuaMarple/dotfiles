require('telescope').load_extension('fzy_native')

require('telescope').setup{
  -- Sharp borders are better
  defaults = {
   borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
}
