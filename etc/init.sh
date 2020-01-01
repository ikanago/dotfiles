#!/bin/sh

DOTFILES_GITHUB="https://github.com/ikanago/dotfiles.git"; export DOTFILES_GITHUB
DOTPATH="~/dotfiles"

# Returns if executable $1 exists in $PATH.
is_exists() {
	which "$1" >/dev/null 1>&2
	return $?
}

install_executable() {
	for file in $(ls $DOTPATH/init)
	do
		sh "$file"
	done
}

sudo apt update
sudo apt -y upgrade

if is_exists "git"; then
	git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
else
	echo "Required git."
	exit 1
fi

install_executable
sh "$DOTPATH/deploy.sh"

