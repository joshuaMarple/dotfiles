local project_telescope = {}
local project_root=vim.api.nvim_eval('projectroot#guess()')
local project_root_dirs = {search_dirs={vim.api.nvim_eval('projectroot#guess()')}}

function project_telescope.project_find_files()
  require('telescope.builtin').find_files({search_dirs={vim.api.nvim_eval('projectroot#guess()')}})
end

function project_telescope.project_grep()
  require('telescope.builtin').live_grep({search_dirs={vim.api.nvim_eval('projectroot#guess()')}})
end

return project_telescope
