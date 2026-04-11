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

#: Completion Menu & Selection
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

#: Intelligence & Correction
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' approximate-max-errors 2

#: Formatting & Grouping
zstyle ':completion:*' format '%B%F{yellow}--- %d ---%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose true

#: Performance & Caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${HOME}/.config/zsh/cache"

#: Specific Helpers (Kill Command)
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#: Settings
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-compctl false