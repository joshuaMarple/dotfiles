-- UI, themes, and visual plugins
local add = require('mini.deps').add

-- UI and Themes
add({ source = 'joshuaMarple/galaxyline.nvim', checkout = 'main' })
add('joshuaMarple/nvim-colorizer.lua')
add('sainnhe/edge')
add({ source = 'joshuaMarple/dotline.nvim'})
require('dotline')
