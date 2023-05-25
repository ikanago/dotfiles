#!/bin/sh

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

function deploy_dotfiles() {
    if [ ! $(command -v chezmoi) ]; then
        log "chezmoi is not installed yet"
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    fi

    chezmoi -v apply
}

function install_fzf_script() {
    log "Install fzf scripts"
    yes | /opt/homebrew/opt/fzf/install
}

function install_via_brew() {
    log "Install softwares via Homebrew"

    brew install \
        bat \
        cmake \
        dust \
        exa \
        fd \
        fzf \
        gcc \
        gh \
        ghq \
        git-delta \
        go \
        gpg \
        hadolint \
        hexyl \
        htop \
        hyperfine \
        jq \
        kubectl \
        mercurial \
        n \
        neovim \
        procs \
        ripgrep \
        starship \
        tmux \
        tokei \
        wget \
        xh \
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

log "Install softwares for macOS"

./common/install-rustup.sh

deploy_dotfiles
install_fzf_script
install_via_brew

log "Install completed"

