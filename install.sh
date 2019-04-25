#...


for f in .??*
do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitignore" ] && continue
	ln -s $HOME/dotfiles/$f $HOME/$f
done
