#!/bin/sh
set -eu
DOTFILES_HOME=$PWD/dotfiles

cd $DOTFILES_HOME

echo 'Creating symbolic links to dotfiles'
find . -type d | xargs -I '{}' mkdir -p "${HOME}/{}"
find . -type f | xargs -I '{}' ln -snvf "${DOTFILES_HOME}/{}" "${HOME}/{}"

