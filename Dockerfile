# Use a base image with your desired Linux distribution
FROM ubuntu:latest

# Update the package manager and install necessary dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    zsh \
    tmux \
    ranger \
    ripgrep \
    git \
    zoxide \
    curl \
    wget \
    tree \
    unzip \
    software-properties-common
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update && apt-get install -y \
    neovim

RUN echo 'root:Docker!' | chpasswd

# Set Zsh as the default shell
RUN chsh -s /usr/bin/zsh

# Set up a non-root user for running your development environment
ARG USER=dev

COPY ./ /home/$USER/dotfiles

RUN useradd -ms /usr/bin/zsh $USER && \
    chown -R $USER:$USER /home/$USER
RUN echo 'dev:password' | chpasswd
USER $USER
WORKDIR /home/$USER

RUN mkdir /home/$USER/docker && chown -R $USER:$USER /home/$USER/docker
RUN mkdir /home/$USER/projects && chown -R $USER:$USER /home/$USER/projects

# Clone the dotfiles repository
# RUN git clone https://gitlab.com/jmarple/dotfiles.git ~/.dotfiles

# Set up Tmux configuration
RUN ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
RUN ~/.tmux/plugins/tpm/scripts/install_plugins.sh # install plugins
# Set up Zsh configuration
RUN ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
# Set up Neovim configuration
RUN mkdir ~/.config
RUN ln -s ~/dotfiles/nvim ~/.config/nvim
RUN ln -s ~/dotfiles/zsh/aliases ~/.bash_aliases

# Set up Neovim configuration
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
RUN nvim +PlugInstall +qall; exit 0;

# Download Znap, if it's not there yet.
RUN git clone --depth 1 -- https://github.com/marlonrichert/zsh-snap.git ~/zsh/snap/zsh-znap
# RUN ~/Repos/znap/znap.zsh pull # Start Znap
RUN zsh -c 'source ~/zsh/snap/zsh-znap/znap.zsh && znap pull && znap restart';

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

# Create a volume that points to ~/docker
VOLUME ["/home/dev/docker"]

# Set the entrypoint to start Tmux
# ENTRYPOINT ["tmux"]

