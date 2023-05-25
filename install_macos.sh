#!/bin/sh

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

function install_via_brew_macos() {
    info "Install softwares via Homebrew for macOS"

    brew install \
        cmake \
        gcc \
        wget \
        koekeishiya/formulae/yabai \
        koekeishiya/formulae/skhd

    brew install --cask \
        alacritty \
        discord \
        font-hack-nerd-font \
        raycast \
        slack \
        spotify \
        zoom
}

info "Install software for macOS"

./common/install_by_homebrew.sh
./common/install_fzf_script.sh
./common/install_rustup.sh
./common/install_dotfiles.sh

install_via_brew_macos

info "Install completed"

