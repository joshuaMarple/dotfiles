sudo apt-get update
sudo apt-get upgrade

git pull

nvim +'PlugInstall --sync' +qa
nvim +'PlugUpdate' +qa
nvim +'PlugUpgrade' +qa
nvim +'PlugClean' +qa

~/.tmux/plugins/tpm/scripts/install_plugins.sh # install plugins

