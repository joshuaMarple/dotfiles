#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Installing dotfiles from $DOTFILES_DIR"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ -f /etc/debian_version ]]; then
    OS="debian"
else
    echo "Unsupported OS. This script supports macOS and Debian/Ubuntu."
    exit 1
fi

# Detect architecture
ARCH=$(uname -m)

install_system_packages() {
    echo "==> Installing system packages..."
    if [[ "$OS" == "macos" ]]; then
        if ! command -v brew &> /dev/null; then
            echo "    Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install git zsh tmux ripgrep jq neovim fzf
    else
        sudo apt-get update
        sudo apt-get install -y \
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
            xclip
        sudo rm -rf /var/lib/apt/lists/*
    fi
}

install_neovim() {
    if [[ "$OS" == "macos" ]]; then
        echo "    Neovim installed via Homebrew"
        return
    fi

    if command -v nvim &> /dev/null; then
        echo "    Neovim already installed"
        return
    fi

    echo "==> Installing Neovim..."
    if [[ "$ARCH" == "x86_64" ]]; then
        curl -LO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
        sudo mkdir -p /opt/nvim
        sudo tar -xzf "nvim-linux-x86_64.tar.gz" --strip-components=1 -C /opt/nvim
        sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
        rm "nvim-linux-x86_64.tar.gz"
    elif [[ "$ARCH" == "aarch64" ]]; then
        curl -LO "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-arm64.tar.gz"
        sudo mkdir -p /opt/nvim
        sudo tar -xzf "nvim-linux-arm64.tar.gz" --strip-components=1 -C /opt/nvim
        sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
        rm "nvim-linux-arm64.tar.gz"
    else
        echo "    Unsupported architecture for Neovim: $ARCH"
    fi
}

setup_locale() {
    if [[ "$OS" == "macos" ]]; then
        return
    fi

    echo "==> Setting up locale..."
    sudo locale-gen en_US.UTF-8 || true
}

install_zoxide() {
    if command -v zoxide &> /dev/null; then
        echo "    zoxide already installed"
        return
    fi

    echo "==> Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

install_fzf() {
    if [[ -d "$HOME/.fzf" ]]; then
        echo "    fzf already installed"
        return
    fi

    if [[ "$OS" == "macos" ]]; then
        echo "    fzf installed via Homebrew"
        return
    fi

    echo "==> Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
    sudo ln -sf ~/.fzf/bin/fzf /usr/local/bin/fzf || true
}

install_tpm() {
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        echo "    TPM already installed"
        return
    fi

    echo "==> Installing TPM (Tmux Plugin Manager)..."
    git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_nodejs() {
    if command -v node &> /dev/null; then
        echo "    Node.js already installed: $(node --version)"
        return
    fi

    echo "==> Installing Node.js..."
    if [[ "$OS" == "macos" ]]; then
        brew install node@20
    else
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install -y nodejs
        sudo rm -rf /var/lib/apt/lists/*
    fi
}

install_claude() {
    if command -v claude &> /dev/null; then
        echo "    Claude Code already installed"
        return
    fi

    echo "==> Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
    mkdir -p ~/.claude
    echo '{"theme":"light"}' > ~/.claude/settings.json
}

setup_placeholders() {
    echo "==> Creating placeholder files..."
    mkdir -p ~/.config ~/.local/bin
    touch ~/.secrets.sh
}

link_dotfiles() {
    echo "==> Linking dotfiles..."

    # Neovim
    if [[ -d "$DOTFILES_DIR/nvim" ]]; then
        ln -sf "$DOTFILES_DIR/nvim" ~/.config/nvim
        echo "    Linked nvim config"
    fi

    # Zsh
    if [[ -f "$DOTFILES_DIR/zsh/zshrc" ]]; then
        ln -sf "$DOTFILES_DIR/zsh/zshrc" ~/.zshrc
        echo "    Linked zshrc"
    fi

    if [[ -f "$DOTFILES_DIR/zsh/zshenv" ]]; then
        ln -sf "$DOTFILES_DIR/zsh/zshenv" ~/.zshenv
        echo "    Linked zshenv"
    fi

    if [[ -f "$DOTFILES_DIR/zsh/aliases" ]]; then
        ln -sf "$DOTFILES_DIR/zsh/aliases" ~/.bash_aliases
        echo "    Linked aliases"
    fi

    # Tmux
    if [[ -f "$DOTFILES_DIR/tmux/tmux.conf" ]]; then
        ln -sf "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf
        echo "    Linked tmux.conf"
    fi
}

install_tmux_plugins() {
    if [[ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]]; then
        echo "==> Installing tmux plugins..."
        ~/.tmux/plugins/tpm/bin/install_plugins || true
    fi
}

set_default_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "    zsh is already the default shell"
        return
    fi

    echo "==> Setting zsh as default shell..."
    if command -v zsh &> /dev/null; then
        chsh -s "$(which zsh)" || echo "    Could not change shell. Run: chsh -s \$(which zsh)"
    fi
}

# Run installation
install_system_packages
install_neovim
setup_locale
install_zoxide
install_fzf
install_tpm
install_nodejs
install_claude
setup_placeholders
link_dotfiles
install_tmux_plugins
set_default_shell

echo ""
echo "========================================"
echo "  Dotfiles installation complete!"
echo "========================================"
echo ""
echo "  Restart your shell or run: exec zsh"
echo ""
