#!/bin/sh

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

info "Install fzf scripts"
yes | /opt/homebrew/opt/fzf/install

