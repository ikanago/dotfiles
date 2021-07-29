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
if [ $(command -v dircolors) ]; then
    eval "$(dircolors -b)"
fi
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

# Jump directories quickly
zinit load agkozak/zsh-z

# Load aliases and useful functions
for file in $HOME/.{aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Vim like key binding on terminal
bindkey -v

# Search and move to a repository easily
# `search_ghq` is defined at .functions
zle -N search_ghq
bindkey "^g" search_ghq

# starship
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval $(pyenv init --path)
fi

# cargo
source "$HOME/.cargo/env"

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ikanago/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ikanago/google-cloud-sdk/completion.zsh.inc'; fi

