#!/bin/bash

set -eu

function ensure_command() {
    if [ ! $(command -v $1 ) ]; then
        echo "Install $1 first"
    fi
}

function install_chezmoi() {
    local dotfiles_dir="$HOME/.local/share/chezmoi"
    if [ "$(/bin/ls -A $dotfiles_dir 2>/dev/null)" ]; then
        return 0
    fi

    ensure_command "curl"
    echo "Install chezmoi"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    echo "Clone dotfiles repo"
    $HOME/.local/bin/chezmoi init https://github.com/ikanago/dotfiles.git
    echo "dotfiles are cloned to $dotfiles_dir"
}

function install_rustup() {
    if [ ! $(command -v rustup) ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
}

install_chezmoi
install_rustup
