#!/bin/sh

DOTPATH="$HOME/dotfiles"

# Returns if executable $1 exists in $PATH.
is_exists() {
	which "$1" >/dev/null 1>&2
	return $?
}

install_executable() {
	INIT=$DOTPATH/etc/init
	for file in $(ls $INIT)
	do
		sh "$INIT/$file"
	done
}

sudo apt update
sudo apt -y upgrade
pwd

if is_exists "git"; then
	git clone --recursive "$DOTFILES_GITHUB" "$DOTPATH"
else
	echo "Required git."
	exit 1
fi

install_executable
sh "$DOTPATH/deploy.sh"

