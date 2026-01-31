#!/usr/bin/env bash
set -euo pipefail

# Smoke tests for dotfiles environment
# Run inside the devcontainer or on a configured system

echo "=== Dotfiles Smoke Tests ==="

echo "Testing zsh..."
zsh -c 'echo "zsh ok"'

echo "Testing nvim starts..."
nvim --headless +qa

echo "Testing required tools..."
for tool in fzf rg zoxide tmux node; do
  if command -v "$tool" &> /dev/null; then
    echo "  $tool: ok"
  else
    echo "  $tool: MISSING"
    exit 1
  fi
done

echo "Testing tmux config..."
tmux -f ~/.tmux.conf start-server \; kill-server

echo "Testing neovim config loads..."
nvim --headless -c 'echo "config loaded"' -c 'qa'

echo "All smoke tests passed"
