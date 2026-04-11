#=========================History==========
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt extended_history       # Write the history file in the ":start:elapsed;command" format
setopt hist_expire_dups_first # Expire duplicate entries first when trimming history
setopt hist_ignore_dups       # Do not record an entry that was just recorded
setopt hist_ignore_all_dups   # Delete old recorded entry if new entry is a duplicate
setopt hist_find_no_dups      # Do not display a line previously found
setopt hist_ignore_space      # Do not record an entry starting with a space
setopt hist_save_no_dups      # Do not write duplicate entries in the history file
setopt hist_reduce_blanks     # Remove superfluous blanks before recording
setopt inc_append_history     # Write to the history file immediately, not when the shell exits
setopt hist_verify            # Do not execute immediately upon history expansion

#: This hook prevents boring or sensitive commands from cluttering the history file
# Ignore commands shorter than 3 characters
# Ignore commands containing sensitive keywords
zshaddhistory() {
    emulate -L zsh
    [[ ${#1} -lt 3 ]] && return 1
    [[ $1 != (ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)* ]] && \
    [[ $1 != *(password|token|key|secret)* ]]
}
