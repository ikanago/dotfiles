#!/bin/bash

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

if [ ! $(command -v rustup) ]; then
    info "rustup is not installed yet"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi


