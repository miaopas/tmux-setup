#!/bin/bash

# Script to install TPM and configure tmux

set -e

echo "Starting tmux setup..."

# 1. Install TPM if not installed
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "TPM already installed."
fi

# 2. Backup existing .tmux.conf
if [ -f "$HOME/.tmux.conf" ]; then
    echo "Backing up existing .tmux.conf to .tmux.conf.bak"
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
fi

# 3. Link or copy the tmux.conf
echo "Deploying new tmux.conf..."
cp "$(dirname "$0")/tmux.conf" "$HOME/.tmux.conf"

# 4. Reload tmux if inside a session
if [ -n "$TMUX" ]; then
    echo "Reloading tmux config..."
    tmux source-file ~/.tmux.conf
fi

echo "tmux setup completed!"
echo "Remember to press prefix + I inside tmux to install plugins."
