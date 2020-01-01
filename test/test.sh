#!/bin/sh

git clone git@github.com:ikanago/dotfiles.git
DOTPATH="~/dotfiles"
sh "$DOTPATH/etc/init.sh"
