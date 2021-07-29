# General
export EDITOR="nvim"

# Do not clear the screen after quitting a man page
export MANPAGER="less -X"

# Go
export GOPATH="$HOME/go"

# starship
export STARSHIP_CONFIG=~/.starship.toml

# fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!thirdparty/*"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!thirdparty/*"'

# n(node version manager)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

# gpg
export GPG_TTY=$(tty)

typeset -gU PATH path

path=(
    "/bin"(N-/)
    "/sbin"(N-/)
    "/usr/bin"(N-/)
    "/usr/local/bin"(N-/)
    "/usr/local/sbin"(N-/)
    "/usr/sbin"(N-/)
    "${path[@]}"
)
path=(
    "$HOME/.cargo/bin"(N-/)
    $(yarn global bin)(N-/)
    "$PYENV_ROOT/bin"(N-/)
    "${path[@]}"
)

# Linuxbrew
if [ $(uname) = "Linux" ]; then
    path=(
        "/home/linuxbrew/.linuxbrew/bin"(N-/)
        "${path[@]}"
    )
fi

