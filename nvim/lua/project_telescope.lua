local project_telescope = {}
local project_root=vim.api.nvim_eval('projectroot#guess()')
local project_root_dirs = {search_dirs={project_root}}

function project_telescope.project_find_files()
  require('telescope.builtin').find_files(project_root_dirs)
end

function project_telescope.project_grep()
  require('telescope.builtin').live_grep(project_root_dirs)
end

return project_telescope
