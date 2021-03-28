" Sharp borders are better
lua << EOF
require('telescope').setup{
defaults = {
 borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
 }
}
EOF

" Pear tree breaks Telescope
let g:pear_tree_ft_disabled = ['TelescopePrompt']
