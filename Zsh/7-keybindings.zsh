#=========================keybindings====================
bindkey '^U' backward-kill-line     # Ctrl + U
bindkey '^[[3;2~' kill-line           # Alt+Del
bindkey '^[[1;3D' backward-word       # Alt+←
bindkey '^[[1;3C' forward-word        # Alt+→

#================ pluguin autosuggest==============
bindkey '^[[1;5C' autosuggest-partial-accept  # Ctrl+→
bindkey '^[[3;5~' autosuggest-clear           # Ctrl+Del