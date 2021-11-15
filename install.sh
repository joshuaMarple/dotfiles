#! /usr/bin/env bash
sudo -S apt-get update
sudo -S apt-get -y dist-upgrade
sudo -S apt-get -y install \
  ranger \
  tmux \
  zsh \
  openjdk-11-jdk \
  default-jre \
  spell 

## Install neovim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -P ~/bin
chmod u+x ~/bin/nvim.appimage
ln -s ~/bin/nvim.appimage ~/bin/nvim

## Install latest zoxide
curl -sS https://webinstall.dev/zoxide | bash

## Install Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

sudo -S apt-get autoremove

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s ~/dotfiles/zsh/aliases ~/.bash_aliases
ln -s ~/dotfiles/zsh/zshenv ~/.zshenv
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim
mkdir ~/.config/kitty
ln -s ~/dotfiles/kitty ~/.config/kitty

nvim +'PlugInstall --sync' +qa

# setup tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

~/.tmux/plugins/tpm/scripts/install_plugins.sh # install plugins

# setup zgen
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# setup fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf -P ~/.fonts

# setup fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# setup git
git config --global user.name "Joshua Marple"
git config --global user.email "joshua.d.marple@gmail.com"
git config --global --unset core.editor
git config --local --unset core.editor

