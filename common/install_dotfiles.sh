#!/bin/sh

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

if [ ! $(command -v chezmoi) ]; then
    info "chezmoi is not installed yet"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
fi

chezmoi -v apply

