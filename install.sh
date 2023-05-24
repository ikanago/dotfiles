function bootstrap() {
    if [ "$(/bin/ls -A1 $HOME/.local/share/chezmoi)" ]; then
        # dotfiles directory is already populated
        return 0
    fi

    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
    chezmoi init https://github.com/ikanago/dotfiles.git
    chezmoi cd
}

bootstrap

if [ $(uname) == 'Darwin' ]; then
    ./install-macos.sh
fi

