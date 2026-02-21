#
# Requires a Nerd Font–compatible font to display properly
# My personal Oh My Zsh theme
#
#

#Exit if not an interactive shell
[[ $- == *i* ]] || return

# To avoid double echo
# This basically helps Zsh render everything properly: it first reads
# and then tells the prompt what to display
setopt prompt_subst

# -------------------------------------------------
# Function that shows if a command failed
# -------------------------------------------------
prompt_exit_status() {
  # Only show the error if the command failed
  print -nr -- "%(?..%F{red}%K{red}%F{white}✘ %?%f%k%F{red}%f )"
}

# -------------------------------------------------
# Function to indicate the IDE / editor
# -------------------------------------------------
prompt_editor_indicator() {
  if [[ -n $NVIM ]]; then
    print -nP "%F{green} %f "
  elif [[ -n $VIM ]]; then
    print -nP "%F{red} %f "
  elif [[ $TERM_PROGRAM == "vscode" || -n $VSCODE_PID ]]; then
    print -nP "%F{blue}󰨞 %f "
  fi
}

# -------------------------------------------------
# Main prompt function
# -------------------------------------------------
prompt_current_dir() {
  local BG_PACMAN="#050505"
  local BG_PATH="#06bbbb"
  local BG_GHOSTS="#030303"
  
  local SEP_OPEN="%F{$BG_PACMAN}"
  local PACMAN="%F{yellow}%K{$BG_PACMAN} 󰮯 "
  local CIRCLE="%F{#ffffff}"
  local GHOST_1="%F{#05bbbb}󱙝"
  local GHOST_2="%F{#ff960c}󱙝"
  local GHOST_3="%F{#ff1b5f}󱙝"
  local SEP_CLOSE="%F{$BG_GHOSTS}%k%f"

  if [[ "$PWD" == "$HOME" ]]; then
    # Home: Only Pacman and dots
    print -nP "$SEP_OPEN$PACMAN%F{$BG_PACMAN}%K{$BG_GHOSTS}%F{#ffffff}$CIRCLE $CIRCLE $CIRCLE $GHOST_1 $SEP_CLOSE"
  else
    # Outside Home: Includes the current directory (%2c) to show the last 2 directories
    local DIR_BLOCK="%F{$BG_PACMAN}%K{$BG_PATH}%F{black}  %U%B%2c%b%u %F{$BG_PATH}%K{$BG_GHOSTS}"
    print -nP "$SEP_OPEN$PACMAN$DIR_BLOCK $GHOST_1 $GHOST_2 $GHOST_3 $SEP_CLOSE"
  fi
}

# -------------------------------------------------
# Git function
# -------------------------------------------------
# ZSH_THEME_GIT_PROMPT_* depends on the "git" plugin,
# meaning it must be enabled in .zshrc
# Green color for the bubble and black for letters and icons
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#006809}%K{#006809}%F{black}%B "
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%F{#006809}%k%f "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red} ✘" 
ZSH_THEME_GIT_PROMPT_CLEAN="%F{black}  " 

ZSH_THEME_GIT_PROMPT_ADDED="%F{#00db12} ✚" # green
ZSH_THEME_GIT_PROMPT_MODIFIED="%F{#cc00e7} ✹" # purple
ZSH_THEME_GIT_PROMPT_DELETED="%F{#ff0000} ✖"  # red
ZSH_THEME_GIT_PROMPT_RENAMED="%F{#e700ad} ➜"  # magenta
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{#d0e700} ═"  # yellow
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{#00e7b5} ✭"  # cyan

# -------------------------------------------------
# Prompt function
# -------------------------------------------------

readonly PROMPT='$(prompt_exit_status)$(prompt_editor_indicator)$(prompt_current_dir) $(git_prompt_info)
%F{blue}  %f'
RPROMPT='$(git_prompt_status)'
