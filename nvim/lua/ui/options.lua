-- UI-related options (loaded after plugins)
local opt = vim.opt

-- Visual appearance
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3
opt.number = true
opt.termguicolors = true
opt.splitright = true

-- Colorscheme and highlighting
opt.background = 'light'
vim.cmd('silent! colorscheme edge')
vim.api.nvim_set_hl(0, 'NonText', { fg = 'bg' })

-- Syntax highlighting
vim.cmd('syntax on')