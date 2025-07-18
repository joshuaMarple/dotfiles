local project_telescope = {}

function project_telescope.project_find_files()
  local root = vim.b.projectroot or vim.fn.getcwd()
  require('telescope.builtin').find_files({search_dirs={root}})
end

function project_telescope.project_grep()
  local root = vim.b.projectroot or vim.fn.getcwd()
  require('telescope.builtin').live_grep({search_dirs={root}})
end

return project_telescope
