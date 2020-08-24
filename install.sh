sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install \
  nvim \
  ranger \
  tmux \
  zsh \
  gnome-terminal \
  signal-desktop \
  openjdk-11-jdk \
  default-jre \
  urlview \
  python3 \
  python3-pip \
  build-essential \ #ycm
  cmake \ #ycm
  python3-dev \ #ycm
  ruby \ #tmux jump
  node-js

npm install -g @angular/cli

echo "Do you wish to backup your existing dotfiles before continuing? [y/n]"
select yn in "y" "n"; do
  case $yn in
      y ) mkdir .old/; \
        mv ~/.bash_aliases \
           ~/.zshrc \
           ~/.tmux.conf \
           ~/.config/nvim/init.vim \
           ~/.old; \
           break;;
      n ) exit;;
  esac
done

ln -s ~/dotfiles/aliases ~/.bash_aliases
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
mkdir ~/.config/nvim
ln -s ~/dotfiles/nvimrc ~/.config/nvim/init.vim
cp ./oh-my-zsh ~/.oh-my-zsh

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
sudo apt install ./pathpicker*.deb

# setup fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf\n~/.fzf/install

# install YCM (separate steps in case one fails)
python3 ~/.vim/plugged/YouCompleteMe/install.py --all
python3 ~/.vim/plugged/YouCompleteMe/install.py --java-completer
python3 ~/.vim/plugged/YouCompleteMe/install.py --ts-completer

# setup git
git config --global user.name "Joshua Marple"
git config --global user.email "joshua.d.marple@gmail.com"

# put update script into /usr/bin/local
sudo ln -s ~/dotfiles/update.sh /usr/local/bin/update

