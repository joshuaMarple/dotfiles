if not vim.g.loaded_devicons then
  return
end

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  ["help"] = {
    icon = "",
    color = "#428850",
    name = "help"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = false;
}
