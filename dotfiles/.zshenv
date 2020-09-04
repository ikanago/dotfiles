# cargo
export PATH="$HOME/.cargo/bin:$PATH"

# starship
export STARSHIP_CONFIG=~/.starship.toml

# n(node version manager)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# yarn
export PATH="$(yarn global bin):$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# haskell-ide-engine
export PATH="$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"

