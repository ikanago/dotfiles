#!/bin/bash

set -eu

PROCNAME=${0##*/}

source ./common/log.sh

info "Install software for Ubuntu"

./common/install_dotfiles.sh

info "Install completed"

