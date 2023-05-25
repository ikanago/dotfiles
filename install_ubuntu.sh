#!/bin/bash

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

function install_by_apt() {
    info "Install softwares by apt"

    sudo apt update -y

    sudo apt install -y \
        build-essentials \
        file \
        libssl-dev \
        nvim \
        vim \
        zsh
}

function install_linuxbrew() {
    if [ -d "$HOME/linuxbrew/.linuxbrew" ]; then
        info "Install Linuxbrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

info "Install software for Ubuntu"

PATH="$HOME/linuxbrew/.linuxbrew/bin:$PATH" ./common/install_by_homebrew.sh
./common/install_fzf_script.sh
./common/install_fzf_script.sh
./common/install_rustup.sh

install_by_apt

info "Install completed"

