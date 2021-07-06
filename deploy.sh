#!/bin/sh
set -eu
DOTFILES_HOME=$PWD/roles/dotfiles/files

echo 'Creating symbolic links to dotfiles'
find . -type d | xargs -I '{}' mkdir -p "${HOME}/{}"
find . -type f | xargs -I '{}' ln -snvf "${DOTFILES_HOME}/{}" "${HOME}/{}"

