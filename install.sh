#! /usr/bin/env bash
sudo -S apt-get update
sudo -S apt-get dist-upgrade
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

npm install -g @angular/cli

while true; do
  read -p "Would you like to backup your existing dotfiles? [yn]" yn
  case $yn in
      [Yy]* ) mkdir ~/.old/; \
           mv ~/.bash_aliases \
           ~/.zshrc \
           ~/.tmux.conf \
           ~/.config/nvim/init.vim \
           ~/.old/; \
           break;;
      [Nn]* ) rm ~/.bash_aliases \
           ~/.zshrc \
           ~/.tmux.conf \
           ~/.config/nvim/init.vim;
           break;;
      * ) echo "Please answer yes or no.";;
  esac
done

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s ~/dotfiles/aliases ~/.bash_aliases
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
mkdir ~/.config
mkdir ~/.config/nvim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim

nvim +'PlugInstall --sync' +qa

# setup tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)" # fancy colors
~/.tmux/plugins/tpm/scripts/install_plugins.sh # install plugins

# setup zgen
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# setup fonts
wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Inconsolata/complete/Inconsolata%20Nerd%20Font%20Complete.otf -P ~/.fonts

# install pathpicker
mkdir projects
cd projects
git clone https://github.com/facebook/PathPicker.git
cd PathPicker/debian
./package.sh
cd ..
sudo -S apt install ./pathpicker*.deb

# setup fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# install YCM (separate steps in case one fails)
python3 ~/.vim/plugged/YouCompleteMe/install.py --all
python3 ~/.vim/plugged/YouCompleteMe/install.py --java-completer
python3 ~/.vim/plugged/YouCompleteMe/install.py --ts-completer

# setup git
git config --global user.name "Joshua Marple"
git config --global user.email "joshua.d.marple@gmail.com"

# put update script into /usr/bin/local
sudo -S ln -sf ~/dotfiles/update.sh /usr/local/bin/update

