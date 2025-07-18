-- File and search-related autocommands
local group = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Incsearch highlight
local incsearch_group = group('vimrc-incsearch-highlight', { clear = true })
autocmd('CmdlineEnter', {
  group = incsearch_group,
  pattern = '[/\\?]',
  command = 'set hlsearch',
})
autocmd('CmdlineLeave', {
  group = incsearch_group,
  pattern = '[/\\?]',
  command = 'set nohlsearch',
})

-- Project root detection with caching
local project_cache = {}

local function get_project_root(path)
  if project_cache[path] then
    return project_cache[path]
  end
  
  local root = vim.fs.find({'.git', 'package.json', 'Cargo.toml', 'go.mod'}, {
    upward = true,
    stop = vim.env.HOME,
    path = path,
  })[1]
  
  local project_root = root and vim.fs.dirname(root) or vim.fn.getcwd()
  project_cache[path] = project_root
  return project_root
end

local projectroot_group = group('UpdateProjectRoot', { clear = true })
autocmd('BufEnter', {
  group = projectroot_group,
  pattern = '*',
  callback = function()
    local buf_path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    vim.b.projectroot = get_project_root(buf_path)
  end,
})