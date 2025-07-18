-- Core module initialization
-- Set leader key _before_ loading mappings
vim.g.mapleader = ' '

-- Load core components
require('core.options')
require('core.autocmds')
require('core.keymaps')

-- Core plugin manager bootstrap
-- Step 1: Bootstrap 'mini.nvim' if not present
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini_path) then
  vim.notify('Installing `mini.nvim`. Please restart Neovim after installation.', vim.log.levels.INFO, { title = 'Plugin Install' })
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/joshuaMarple/mini.nvim', mini_path })
  vim.cmd('helptags ALL')
  vim.notify('`mini.nvim` has been installed. Please restart Neovim.', vim.log.levels.INFO, { title = 'Plugin Install' })
  return
end

-- Step 2: Set up 'mini.deps'
vim.opt.packpath:prepend(path_package)
require('mini.deps').setup({ path = { package = path_package } })

-- Step 3: Set up core mini.nvim plugins
local add = require('mini.deps').add

add({
  source = 'joshuaMarple/mini.nvim',
  config = function()
    require('mini.comment').setup()
    require('mini.pick').setup()
    require('mini.icons').setup()
    -- Compatibility shim for nvim-web-devicons
    package.loaded['nvim-web-devicons'] = require('mini.icons')
    require('mini.bracketed').setup()
    require('mini.cursorword').setup()
    require('mini.pairs').setup()
    require('mini.ai').setup()
    require('mini.indentscope').setup()
    require('mini.trailspace').setup()
    require('mini.surround').setup()
    require('mini.completion').setup({
      lsp_completion = {
        source_func = 'completefunc',
        auto_setup = false,
      },
    })
    local starter = require('mini.starter')
    starter.setup({
        items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(10, false),
          starter.sections.recent_files(10, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.aligning('center', 'center'),
        },
      })
  end
})
