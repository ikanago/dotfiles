#!/bin/bash

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

info "Install softwares via Homebrew"

brew install \
    bat \
    dust \
    exa \
    fd \
    fzf \
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
    xh \

