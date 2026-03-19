setopt prompt_subst
setopt autocd
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt interactivecomments
setopt GlobComplete
setopt complete_aliases
setopt complete_in_word

setopt correct
unsetopt correct_all

autoload -Uz zmv
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format '%B%F{yellow}--- %d ---%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.config/zsh/cache"