#!/bin/bash

set -eu

DOTFILES_DIR="$HOME/ghq/github.com/ikanago/dotfiles"

function install_nix() {
    if command -v nix >/dev/null; then
        return 0
    fi

    echo "Install Nix"
    curl -fsSL https://nixos.org/nix/install | sh -s -- --daemon --yes
    # shellcheck disable=SC1091
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
}

function clone_dotfiles() {
    if [ -d "$DOTFILES_DIR/.git" ]; then
        return 0
    fi

    git clone https://github.com/ikanago/dotfiles "$DOTFILES_DIR"
    echo "dotfiles are cloned to $DOTFILES_DIR"
}

# The Nix installer writes these files, and nix-darwin refuses to overwrite them.
function backup_etc() {
    local f
    for f in /etc/nix/nix.conf /etc/zshrc /etc/bashrc; do
        if [ -f "$f" ] && [ ! -L "$f" ]; then
            sudo mv "$f" "$f.before-nix-darwin"
        fi
    done
}

function switch() {
    local host="personal"
    [ "$(whoami)" = "nagaoka.yuta" ] && host="work"

    cd "$DOTFILES_DIR"
    sudo -H nix --extra-experimental-features "nix-command flakes" run nix-darwin/master#darwin-rebuild -- switch --flake ".#${host}"
}

install_nix
clone_dotfiles
backup_etc
switch
