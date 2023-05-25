#!/bin/bash

set -eu

function bootstrap() {
    local dotfiles_dir="$HOME/.local/share/chezmoi"
    if [ "$(/bin/ls -A1 $dotfiles_dir)" ]; then
        # dotfiles directory is already populated
        return 0
    fi

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
fi

