-- UI module initialization
require('ui.plugins')
require('ui.options')  -- Load after plugins to ensure colorscheme is available
require('ui.keymaps')
require('ui.autocmds')