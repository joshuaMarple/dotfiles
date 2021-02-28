filetype plugin indent on
syntax on

set hidden

source ~/dotfiles/nvim/plugins.vim
source ~/dotfiles/nvim/functions.vim
source ~/dotfiles/nvim/settings.vim
source ~/dotfiles/nvim/theme.vim
source ~/dotfiles/nvim/mappings.vim
try
  source ~/.config/nvim/work.vim
catch
  " file not found
endtry
