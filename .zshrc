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
    cd $1 && ls --color=tty -F -la
}

### Added by Zplugin's installer
source '/home/yuta/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zstyle :prompt:pure:path color 033
zstyle :prompt:pure:prompt:success color 034
zstyle :prompt:pure:git:branch color 058

# Load theme
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# Aliases
# commands {{{
alias ls="ls -F --color=tty"
alias la="ls -a"
alias ll="ls -la"
# }}}

# git {{{
alias ga="git add ."
alias gc="git commit"
alias gp="git push"
alias gl="git log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso"
alias gs="git status"
# }}}

# others {{{
alias mdtopdf='docker run -it --rm -v "`pwd`":/workdir plass/mdtopdf mdtopdf'
# }}}
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
source /home/yuta/k/k.sh
source $HOME/.cargo/env

