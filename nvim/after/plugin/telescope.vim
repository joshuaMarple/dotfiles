" Sharp borders are better
lua << EOF
require'telescope'.load_extension('project')
require('telescope').setup{
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
EOF

" Pear tree breaks Telescope
let g:pear_tree_ft_disabled = ['TelescopePrompt', 'frecency']
