#!/bin/bash

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

function ensure_command() {
    if [ ! $(command -v $1 ) ]; then
        error "Install $1 first"
    fi
}

function bootstrap() {
    local dotfiles_dir="$HOME/.local/share/chezmoi"
    if [ "$(/bin/ls -A $dotfiles_dir 2>/dev/null)" ]; then
        return 0
    fi

    ensure_command "curl"
    # Install chezmoi
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    # Clone dotfiles repo to $dotfiles_dir
    chezmoi init https://github.com/ikanago/dotfiles.git
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

