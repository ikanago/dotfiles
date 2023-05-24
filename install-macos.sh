#!/bin/sh

set -eu

function deploy_dotfiles() {
    if [ ! $(command -v chezmoi) ]; then
        sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    fi

    chezmoi -v apply
}

function install_fzf_script() {
    yes | /opt/homebrew/opt/fzf/install
}

function install_via_brew() {
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

deploy_dotfiles
install_fzf_script
install_via_brew

