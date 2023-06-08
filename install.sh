#!/bin/bash

set -eu

function ensure_command() {
    if [ ! $(command -v $1 ) ]; then
        echo "Install $1 first"
    fi
}

function bootstrap() {
    local dotfiles_dir="$HOME/.local/share/chezmoi"
    if [ "$(/bin/ls -A $dotfiles_dir 2>/dev/null)" ]; then
        return 0
    fi

    ensure_command "curl"
    echo "Install chezmoi"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    echo "Clone dotfiles repo"
    $HOME/.local/bin/chezmoi init https://github.com/ikanago/dotfiles.git
    cd "$dotfiles_dir"
}

bootstrap

if [ $(uname) == 'Darwin' ]; then
    ./install_macos.sh
elif [ $(command -v apt) ]; then
    ./install_ubuntu.sh
elif [ $(command -v pacman) ]; then
    ./install_arch.sh
fi

