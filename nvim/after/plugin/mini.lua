local module_checker = require('module_checker')
if not module_checker.IsModuleAvailable('mini') then
  return
end
require('mini.comment').setup()
require('mini.pick').setup()
require('mini.icons').setup()
require('mini.bracketed').setup()
-- require('mini.completion').setup()
require('mini.cursorword').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.indentscope').setup()
require('mini.trailspace').setup()
require('mini.surround').setup()
-- require('mini.statusline').setup()
require('mini.animate').setup()
require('mini.files').setup()
require('mini.completion').setup()
require('mini.deps').setup()
local starter = require('mini.starter')
starter.setup({
    items = {
      starter.sections.telescope(),
      starter.sections.builtin_actions(),
      starter.sections.recent_files(10, false),
      starter.sections.recent_files(10, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
--
-- -- use a release tag to download pre-built binaries
-- MiniDeps.add({
--   source = "saghen/blink.cmp",
--   depends = {
--   "rafamadriz/friendly-snippets",
--   },
--   checkout = "v0.7.3", -- check releases for latest tag
-- })
