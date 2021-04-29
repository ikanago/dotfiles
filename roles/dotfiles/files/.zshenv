# General
export EDITOR="nvim"

# Do not clear the screen after quitting a man page
export MANPAGER="less -X"

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

# go
if [ $(uname) != "Darwin" ]; then
    export GOROOT="/usr/local/go"
    export PATH="$PATH:$GOROOT/bin:$HOME/go/bin"
else
    export PATH="$PATH:$HOME/go/bin"
fi
export GOPATH="$HOME/go"

# starship
export STARSHIP_CONFIG=~/.starship.toml

# Linuxbrew
if [ $(uname) = "Linux" ]; then
    export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi

# fzf
export FZF_DEFAULT_OPTS="--reverse --inline-info"
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!thirdparty/*"'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!thirdparty/*"'

# n(node version manager)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# yarn
export PATH="$(yarn global bin):$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# haskell-ide-engine
export PATH="$HOME/.local/bin:$PATH"

# dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"

# riscv toolchain
export PATH="/opt/rv32/bin:$PATH"

# gpg
export GPG_TTY=$(tty)
