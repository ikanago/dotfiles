#...

for f in .??*
do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitignore" ] && continue
	[ "$f" = ".github" ] && continue
	ln -sfnv $PWD/$f $HOME/$f
done

# Script to recover from `zsh: corrupt history file`.
script=recover_zsh_history.sh 
ln -sfnv $PWD/$script $HOME/$script

mkdir -p $HOME/.config
ln -sfnv $PWD/etc/nvim $HOME/.config
