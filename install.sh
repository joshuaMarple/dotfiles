#! /usr/bin/env bash
sudo -S apt-get update
sudo -S apt-get -y dist-upgrade
sudo -S apt-get -y install \
  neovim \
  ranger \
  tmux \
  zsh \
  gnome-terminal \
  openjdk-11-jdk \
  default-jre \
  urlview \
  python \
  python3 \
  python3-pip \
  build-essential \
  cmake \
  python3-dev \
  ruby \
  nodejs \
  npm

sudo -S apt-get autoremove

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

ln -s ~/dotfiles/aliases ~/.bash_aliases
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim

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

