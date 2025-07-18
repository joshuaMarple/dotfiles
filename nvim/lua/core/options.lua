local opt = vim.opt
local g = vim.g

opt.foldmethod = 'indent'
opt.foldenable = false
opt.fillchars = { fold = ' ' }
opt.foldnestmax = 3
opt.foldminlines = 1

opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.cmd('filetype plugin indent on')

opt.expandtab = true
opt.hidden = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.shiftround = true

opt.autochdir = true
opt.history = 10000
opt.scrolloff = 5

opt.undofile = true
opt.undodir = vim.fn.expand('~/.vim/undo')

g.netrw_banner = 0
g.netrw_liststyle = 3

opt.wildcharm = 26 -- <C-z>
opt.wildignorecase = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.inccommand = 'split'
opt.lazyredraw = true

opt.timeoutlen = 1000
opt.ttimeoutlen = 5
opt.updatetime = 300

if vim.fn.executable('rg') == 1 then
  opt.grepprg = 'rg --vimgrep --no-heading'
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

g.VISUAL = "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
g.EDITOR = "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"
g.FPP_EDITOR = "nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"

g.tpipeline_autoembed = 0

vim.cmd('cabbrev h vert h')
