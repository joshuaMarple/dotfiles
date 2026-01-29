FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000

# System packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    zsh \
    neovim \
    tmux \
    ripgrep \
    fzf \
    jq \
    unzip \
    ncurses-term \
    ca-certificates \
    gnupg \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/zsh $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME

ENV HOME=/home/$USERNAME
ENV PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
ENV TERM=xterm-256color

# zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Create placeholder files dotfiles might expect
RUN mkdir -p ~/.config ~/.local/bin \
    && touch ~/.bash_aliases ~/.secrets.sh

# Copy and run dotfiles setup
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/dotfiles

RUN cd /home/$USERNAME/dotfiles && \
    if [ -f install.sh ]; then \
        chmod +x install.sh && ./install.sh || true; \
    else \
        ln -sf /home/$USERNAME/dotfiles/nvim ~/.config/nvim; \
        ln -sf /home/$USERNAME/dotfiles/zsh/zshrc ~/.zshrc; \
        ln -sf /home/$USERNAME/dotfiles/zsh/zshenv ~/.zshenv; \
        ln -sf /home/$USERNAME/dotfiles/tmux/tmux.conf ~/.tmux.conf 2>/dev/null || true; \
    fi

WORKDIR /workspace
CMD ["zsh"]
