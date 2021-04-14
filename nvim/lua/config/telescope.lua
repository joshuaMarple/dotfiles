require'telescope'.load_extension('project')
require"telescope".load_extension("frecency")
require('telescope').load_extension('fzy_native')

require('telescope').setup{
  -- Sharp borders are better
  defaults = {
   borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
  },
  extensions = {
    frecency = {
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      workspaces = {
         ["nvim"]     = "/home/jmarple/.config",
         ["projects"] = "/home/jmarple/projects",
         ["emerald"]  = "/home/jmarple/projects/emerald"
      }
    }
  },
}
