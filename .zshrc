# Set up the prompt

autoload -Uz promptinit
promptinit

autoload -Uz colors
colors

PROMPT=$'%{\e[30;48;5;016m%}%{\e[38;5;001m%}[%n@%m]%{\e[0m%}'

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle :prompt:pure:path color 033
zstyle :prompt:pure:prompt:success color 034
zstyle :prompt:pure:git:branch color 058

### zinit configuration
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# cd
zinit ice wait lucid
zinit light changyuheng/zsh-interactive-cd

# autosuggestions, trigger precmd hook upon load
zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=10

# Tab completions
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# Syntax highlighting
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zdharma/fast-syntax-highlighting

### Useful Commands
# mkdir and cd simultaneously
function mkcd() {
    if [[ -d $1 ]]; then
	echo "$1 already exists"
	cd $1
    else
	mkdir -p $1 && cd $1
    fi
}

# cd and ls simultaneously
function cl() {
    cd $1 && exa -la
}

# Fuzzy search in repositories
function search_ghq() {
	local target_dir=$(ghq list -p | fzf --query="$LBUFFER" --reverse)
	if [ -n "$target_dir" ]; then
		BUFFER="cd ${target_dir}"
		zle accept-line
	fi
	zle reset-prompt
}
zle -N search_ghq
bindkey "^g" search_ghq

### Aliases
# commands
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"
alias find="fd"
alias ps="procs"
alias grep="rg"
alias time="hyperfine"

# git
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso"
alias gs="git status"
alias gd="git diff"

# others
alias mdtopdf='docker run -it --rm -v "`pwd`":/workdir plass/mdtopdf mdtopdf'
alias dc='docker-compose'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# cargo
export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env

# gvm
source $HOME/.gvm/scripts/gvm

# starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.starship.toml

# OPAM configuration
. /home/yuta/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# n(node version manager)
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# yarn
export PATH="$(yarn global bin):$PATH"

# Java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH="$JAVA_HOME/bin:$PATH"

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# haskell-ide-engine
export PATH="$HOME/.local/bin:$PATH"

# dotnet tools
export PATH="$HOME/.dotnet/tools:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
