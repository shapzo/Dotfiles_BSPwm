#
# Requires a Nerd Font compatible font to display properly
# My personal Oh My Zsh theme
#

# Exit if the shell is not interactive
[[ $- == *i* ]] || return

# Enable prompt substitution and extended globbing
# prompt_subst: Allows the prompt to be dynamic by re-evaluating variables
# extendedglob: Enables advanced pattern matching (used for language detection)
setopt prompt_subst
setopt extendedglob

# Load hook module
autoload -Uz add-zsh-hook

# Load and initialize zsh-async
source /usr/share/zsh/plugins/zsh-async/async.zsh
async_init

# -------------------------------------------------
# Exit Status Indicator
# -------------------------------------------------
prompt_exit_status() {
  # Display the error code only if the last command failed
  local exit_code=$?
  if (( exit_code != 0 )); then
    exit_status="%F{red}%K{red}%F{white}✘ ${exit_code}%f%k%F{red}%f "
  else
    exit_status=""
  fi
}

# -------------------------------------------------
# SSH Connection Detector
# -------------------------------------------------
prompt_ssh_indicator() {
  if [[ -n $SSH_CONNECTION || -n $SSH_CLIENT || -n $SSH_TTY ]]; then
    # Network icon with cyan foreground
    ssh_indicator="%F{#00afff}󰖟 %f"
  else
    ssh_indicator=""
  fi
}

# -------------------------------------------------
# Root Privilege Detector
# -------------------------------------------------
prompt_privilege_indicator() {
  # If User ID is 0 (root)
  if [[ $UID -eq 0 ]]; then
    privilege_indicator="%F{yellow}󱐋%F{red}   %f"
  else
    # Optional: small lock icon for normal users; kept empty to avoid clutter
    privilege_indicator=""
  fi
}

# -------------------------------------------------
# Programming Language Detector
# -------------------------------------------------
prompt_lang_indicator() {
  lang_indicator=""

  # Python: .py files or management files
  if [[ -n *.py(#qN[1]) || -f "requirements.txt" || -f "pyproject.toml" ]]; then
    lang_indicator+="%F{#3776AB} %f"
  fi

  # Rust: .rs files or Cargo manifest
  if [[ -n *.rs(#qN[1]) || -f "Cargo.toml" ]]; then
    lang_indicator+="%F{#E57300} %f"
  fi

  # C / C++: common extensions
  if [[ -n *.(c|cpp|h|hpp)(#qN[1]) ]]; then
    lang_indicator+="%F{#00599C} %f"
  fi

  # JavaScript / TypeScript / Node
  if [[ -n *.(js|ts|jsx|tsx)(#qN[1]) || -f "package.json" ]]; then
    lang_indicator+="%F{#F7DF1E} %f"
  fi

  # Shell scripts
  if [[ -n *.sh(#qN[1]) ]]; then
    lang_indicator+="%F{#4EAA25} %f"
  fi

  # HTML
  if [[ -n *.(html|htm)(#qN[1]) ]]; then
    lang_indicator+="%F{#E34F26} %f"
  fi

  # CSS
  if [[ -n *.css(#qN[1]) ]]; then
    lang_indicator+="%F{#1572B6} %f"
  fi

  # PHP
  if [[ -n *.php(#qN[1]) ]]; then
    lang_indicator+="%F{#777BB4} %f"
  fi

  # Java
  if [[ -n *.java(#qN[1]) ]]; then
    lang_indicator+="%F{#007396} %f"
  fi

  # Docker: Optional indicator
  if [[ -f "Dockerfile" || -f "docker-compose.yml" ]]; then
    lang_indicator+="%F{#2496ED} %f"
  fi
}

# -------------------------------------------------
# Directory Display Function (Pacman Style)
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

  if [[  -z ${PWD#$HOME}  ]]; then
    # At Home: Show Pacman and dots only
    current_dir="$SEP_OPEN$PACMAN%F{$BG_PACMAN}%K{$BG_GHOSTS}%F{#ffffff}$CIRCLE $CIRCLE $CIRCLE $GHOST_1 $SEP_CLOSE"
  else
    # Outside Home: Show current folder (%2~ displays last 2 directories relative to home)
    local DIR_BLOCK="%F{$BG_PACMAN}%K{$BG_PATH}%F{black}  %U%B%2~%b%u %F{$BG_PATH}%K{$BG_GHOSTS}"
    current_dir="$SEP_OPEN$PACMAN$DIR_BLOCK $GHOST_1 $GHOST_2 $GHOST_3 $SEP_CLOSE"
  fi
}

# -------------------------------------------------
# Git Style Global Variables
# -------------------------------------------------
GIT_ICON_ADDED="%F{#00db12} ✚%f"
GIT_ICON_MODIFIED="%F{#cc00e7} ✹%f"
GIT_ICON_DELETED="%F{#ff0000} ✖%f"
GIT_ICON_UNTRACKED="%F{#00e7b5} ✭%f"
GIT_ICON_CLEAN="%F{#00db12} ✔%f"
GIT_ICON_DIRTY="%F{#ff0000} ✘%f"

# Git bubble colors
GIT_PREFIX="%F{#006e0f}%K{#006e0f}%F{#000000}  %B"
GIT_SUFFIX="%b%k%F{#006e0f}%f"

# -------------------------------------------------
# Git Async Worker Task
# -------------------------------------------------
git_worker_task() {
  # Use git -C to execute in the target directory without changing shell location
  local target_dir="$1"
  
  # 1. Fetch branch name or hash quickly
  local ref=$(git -C "$target_dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$target_dir" rev-parse --short HEAD 2>/dev/null)
  [[ -z $ref ]] && return 

  local status_info=""
  local state_icon="$GIT_ICON_CLEAN"

  # 2. Fast "Dirty" detection (ignoring submodules for speed)
  if ! git -C "$target_dir" diff --quiet --ignore-submodules HEAD 2>/dev/null; then
    state_icon="$GIT_ICON_DIRTY"
    
    # Optional: Add specific details if needed (simplified for performance)
    status_info+="$GIT_ICON_MODIFIED"
  fi

  # 3. Detect Untracked files
  if [[ -n $(git -C "$target_dir" ls-files --others --exclude-standard 2>/dev/null) ]]; then
    state_icon="$GIT_ICON_DIRTY"
    status_info+="$GIT_ICON_UNTRACKED"
  fi

  # Assemble the final string using global variables
  echo "${GIT_PREFIX}${ref}${state_icon}${status_info}${GIT_SUFFIX}"
}

# Worker Callback: Triggered when the async task finishes
git_callback() {
  # Only reset prompt if the result has changed to prevent flickering
  if [[ "$git_async" != " $3" ]]; then
    git_async=" $3"
    zle && zle reset-prompt
  fi
}

# Configure Worker
async_start_worker git_worker -n
async_register_callback git_worker git_callback

# Pre-command hook to trigger async job
prompt_trigger_async() {
  # Trigger the job without clearing the variable to maintain UI stability
  async_job git_worker git_worker_task "$PWD"
}

# -------------------------------------------------
# HOOK REGISTRATION
# -------------------------------------------------
add-zsh-hook precmd prompt_exit_status
add-zsh-hook precmd prompt_ssh_indicator
add-zsh-hook precmd prompt_privilege_indicator
add-zsh-hook precmd prompt_lang_indicator
add-zsh-hook precmd prompt_current_dir
add-zsh-hook precmd prompt_trigger_async

# -------------------------------------------------
# Final Prompt Definition
# -------------------------------------------------
# Readonly is used to cache colors and improve rendering performance
readonly PROMPT='${exit_status}${ssh_indicator}${privilege_indicator}${current_dir}${git_async}
%F{blue}  %f'
RPROMPT='${lang_indicator}'