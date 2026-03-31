#=========================keybindings====================
bindkey '^U' backward-kill-line     # Ctrl + U
bindkey '^[[3;2~' kill-line           # Alt+Del
bindkey '^[[1;3D' backward-word       # Alt+←
bindkey '^[[1;3C' forward-word        # Alt+→

#================ pluguin autosuggest==============
bindkey '^[[1;5C' autosuggest-partial-accept  # Ctrl+→
bindkey '^[[3;5~' autosuggest-clear           # Ctrl+Del

#================ pluguin zoxide================
# Register as a ZLE widget and bind to Ctrl+Z
zle -N zfz_zoxide
bindkey '^z' zfz_zoxide
# Register the widget and bind it to Ctrl+F (Find)
zle -N fz_edit_file
bindkey '^f' fz_edit_file
# Extra: Map Ctrl+O to the interactive 'zi' command
bindkey -s '^o' 'zi\n'