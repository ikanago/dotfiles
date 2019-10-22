#...

for f in .??*
do
	[ "$f" = ".git" ] && continue
	[ "$f" = ".gitignore" ] && continue
	ln -sfnv $PWD/$f $HOME/$f
done

#mkdir -p $HOME/.config
ln -sfnv $PWD/nvim $HOME/.config
