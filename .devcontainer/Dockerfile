FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=dev
ARG USER_UID=1001
ARG USER_GID=1001

# System packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    zsh \
    tmux \
    ripgrep \
    jq \
    unzip \
    ncurses-term \
    ca-certificates \
    gnupg \
    locales \
    xclip \
    && rm -rf /var/lib/apt/lists/*

# Neovim (latest stable - x86_64 only)
RUN curl -LO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz" && \
    mkdir -p /opt/nvim && \
    tar -xzf "nvim-linux-x86_64.tar.gz" --strip-components=1 -C /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim && \
    rm "nvim-linux-x86_64.tar.gz"

# Set up locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create user (with empty password for su access)
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/zsh $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && passwd -d $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

ENV HOME=/home/$USERNAME
ENV PATH="$HOME/.fzf/bin:$HOME/.local/bin:$HOME/.bun/bin:$PATH"
ENV TERM=xterm-256color

# zoxide
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# fzf (latest version for --zsh flag support)
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && ~/.fzf/install --all --no-bash --no-fish \
    && sudo ln -s ~/.fzf/bin/fzf /usr/local/bin/fzf

# TPM (Tmux Plugin Manager)
RUN git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Node.js (useful for dev work)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - \
    && sudo apt-get install -y nodejs \
    && sudo rm -rf /var/lib/apt/lists/*

# Claude Code (native installer + light mode)
RUN curl -fsSL https://claude.ai/install.sh | bash \
    && mkdir -p ~/.claude \
    && echo '{"theme":"light"}' > ~/.claude/settings.json

# Create placeholder files dotfiles might expect
RUN mkdir -p ~/.config ~/.local/bin \
    && touch ~/.secrets.sh

# Copy and run dotfiles setup
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/dotfiles

RUN cd /home/$USERNAME/dotfiles && \
    if [ -f install.sh ]; then \
        chmod +x install.sh && ./install.sh || true; \
    else \
        ln -sf /home/$USERNAME/dotfiles/nvim ~/.config/nvim; \
        ln -sf /home/$USERNAME/dotfiles/zsh/zshrc ~/.zshrc; \
        ln -sf /home/$USERNAME/dotfiles/zsh/zshenv ~/.zshenv; \
        ln -sf /home/$USERNAME/dotfiles/zsh/aliases ~/.bash_aliases; \
        ln -sf /home/$USERNAME/dotfiles/tmux/tmux.conf ~/.tmux.conf 2>/dev/null || true; \
    fi

# Pre-install tmux plugins via TPM
RUN ~/.tmux/plugins/tpm/bin/install_plugins || true

# NOTE: Don't pre-install neovim plugins - headless install causes
# "loop or previous error" issues. Plugins install on first interactive use.
# Ref: https://github.com/LazyVim/LazyVim/issues/6367

WORKDIR /workspace
CMD ["zsh"]
