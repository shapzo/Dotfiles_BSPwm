#
# Requires a nerdfont compatible font to display properly
# My zsh theme 
#
#

# Exit if it is not an interactive shell
[[ $- == *i* ]] || return

# To avoid double echoing
# Basically helps zsh render everything: it reads first and then tells the prompt what to display
setopt prompt_subst
setopt extendedglob
# Load hooks module
autoload -Uz add-zsh-hook
# Load zsh async
source /usr/share/zsh/plugins/zsh-async/async.zsh
async_init

# -------------------------------------------------
# Global Variables
# -------------------------------------------------
typeset -g exit_status=""
typeset -g ssh_indicator=""
typeset -g privilege_indicator=""
typeset -g lang_indicator=""
typeset -g current_dir=""
typeset -g git_async=""
typeset -g Last_git_dir=""

# ---- Git Icons ----
typeset -gr GIT_ICON_ADDED="%F{#00db12} ✚ %f"
typeset -gr GIT_ICON_MODIFIED="%F{#cc00e7} ✹ %f"
typeset -gr GIT_ICON_DELETED="%F{#ff0000} ✖ %f"
typeset -gr GIT_ICON_UNTRACKED="%F{#00e7b5} ✭ %f"
typeset -gr GIT_ICON_CLEAN="%F{#00db12} ✔ %f"
typeset -gr GIT_ICON_DIRTY="%F{#ff0000} ✘ %f"

# ---- Git Bubble ----
typeset -gr GIT_PREFIX="%F{#006e0f}%K{#006e0f}%F{#000000}  %B"
typeset -gr GIT_SUFFIX="%b%k%F{#006e0f}%f"

# ---- Prompt Bubble ----
typeset -gr BG_PACMAN="#050505"
typeset -gr BG_PATH="#06bbbb"
typeset -gr BG_GHOSTS="#030303"
  
typeset -gr SEP_OPEN="%F{$BG_PACMAN}"
typeset -gr PACMAN="%F{yellow}%K{$BG_PACMAN} 󰮯 "
typeset -gr CIRCLE="%F{#ffffff}"
typeset -gr GHOST_1="%F{#05bbbb}󱙝"
typeset -gr GHOST_2="%F{#ff960c}󱙝"
typeset -gr GHOST_3="%F{#ff1b5f}󱙝"
typeset -gr SEP_CLOSE="%F{$BG_GHOSTS}%k%f"

# -------------------------------------------------
# Function to show if a command failed
# -------------------------------------------------
prompt_exit_status() {
  # Only shows the error if the command failed
  local exit_code=$?
  if (( exit_code != 0 )); then
    exit_status="%F{red}%K{red}%F{white}✘ ${exit_code}%f%k%F{red}%f "
  else
    exit_status=""
  fi
}

# -------------------------------------------------
# Function to detect SSH
# -------------------------------------------------
prompt_ssh_indicator() {
  if [[ -n $SSH_CONNECTION || -n $SSH_CLIENT || -n $SSH_TTY ]]; then
    ssh_indicator="%F{#00afff}󰖟 %f"
  else
    ssh_indicator=""
  fi
}

# -------------------------------------------------
# Function to detect Privileges (Root)
# -------------------------------------------------
prompt_privilege_indicator() {
  # If user ID is 0 (root)
  if [[ $UID -eq 0 ]]; then
    privilege_indicator="%F{yellow}󱐋%F{red}   %f"
  else
    privilege_indicator=""
  fi
}

# -------------------------------------------------
# Function to detect Languages in the Directory
# -------------------------------------------------
prompt_lang_indicator() {
  lang_indicator=""
  # Python: .py or management files
  if [[ -n *.py(#qN[1]) || -f "requirements.txt" || -f "pyproject.toml" ]]; then
    lang_indicator+="%F{#3776AB} %f"
  fi
  # Rust: .rs or Cargo manifest
  if [[ -n *.rs(#qN[1]) || -f "Cargo.toml" ]]; then
    lang_indicator+="%F{#E57300} %f"
  fi
  # C / C++: common extensions
  if [[ -n *.(c|cpp|h|hpp)(#qN[1]) ]]; then
    lang_indicator+="%F{#00599C} %f"
  fi
  # JavaScript / TypeScript / Node
  if [[ -n *.(js|ts|jsx|tsx)(#qN[1]) || -f "package.json" ]]; then
    lang_indicator+="%F{#F7DF1E} %f"
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
    # Go
  if [[ -n *.go(#qN[1]) || -f "go.mod" ]]; then
    lang_indicator+="%F{#00ADD8}󰟓 %f"
  fi
  # Lua
  if [[ -n *.lua(#qN[1]) ]]; then
    lang_indicator+="%F{#51B2E8} %f"
  fi
  # Ruby
  if [[ -n *.rb(#qN[1]) || -f "Gemfile" ]]; then
    lang_indicator+="%F{#CC342D} %f"
  fi
  # Docker
  if [[ -f "Dockerfile" || -f "docker-compose.yml" ]]; then
    lang_indicator+="%F{#2496ED} %f"
  fi
}

# -------------------------------------------------
# Main Prompt Function
# -------------------------------------------------
prompt_current_dir() {
  if [[  -z ${PWD#$HOME}  ]]; then
  #[[ $PWD == $HOME ]] -> this would be another way but I like this one for now
    # Home: Pacman and dots only
    current_dir="$SEP_OPEN$PACMAN%F{$BG_PACMAN}%K{$BG_GHOSTS}%F{#ffffff}$CIRCLE $CIRCLE $CIRCLE $GHOST_1 $SEP_CLOSE"
  else
    # Outside Home: Includes current folder (%2~) to show the last 2 directories relative to home (could also use 2c)
    local DIR_BLOCK="%F{$BG_PACMAN}%K{$BG_PATH}%F{black}  %U%B%2~%b%u %F{$BG_PATH}%K{$BG_GHOSTS}"
    current_dir="$SEP_OPEN$PACMAN$DIR_BLOCK $GHOST_1 $GHOST_2 $GHOST_3 $SEP_CLOSE"
  fi
}

# -------------------------------------------------
# Git Function
# -------------------------------------------------
# Git "Worker" Function
git_worker_task() {
  # We use -C to run git in the directory without using 'cd'
  local target_dir="$1"
  
  # 1. Get branch fast
  local ref=$(git -C "$target_dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$target_dir" rev-parse --short HEAD 2>/dev/null)
  [[ -z $ref ]] && return 

  local status_info=""
  local state_icon="$GIT_ICON_CLEAN"

  # 2. "Dirty" detection
  if ! git -C "$target_dir" diff --quiet --ignore-submodules HEAD 2>/dev/null; then
    state_icon="$GIT_ICON_DIRTY"
    
    # If dirty, we look for specific details to maintain manual logic or simplify
    status_info+="$GIT_ICON_MODIFIED"
  fi

  # 3. Detect Untracked (New files)
  if git -C "$target_dir" ls-files --others --exclude-standard | read; then
    state_icon="$GIT_ICON_DIRTY"
    status_info+="$GIT_ICON_UNTRACKED"
  fi

  # Assembly using global variables
  echo "${GIT_PREFIX}${ref}${state_icon}${status_info}${GIT_SUFFIX}"
}

# Callback (When the worker finishes)
git_callback() {
  local output="$3"

  # If worker failed or returned nothing
  [[ -z $output ]] && return

  # Only update if it changed
  if [[ "$git_async" != " $output" ]]; then
    git_async=" $output"
    zle && zle reset-prompt
  fi
}

# Setup the Worker
async_start_worker git_worker -n
async_register_callback git_worker git_callback

# Hook to trigger the search
prompt_trigger_async() {
  # If directory hasn't changed → do nothing
  [[ "$PWD" == "$Last_git_dir" ]] && return
  Last_git_dir="$PWD"

  # Fast check if it is a repo
  git -C "$PWD" rev-parse --is-inside-work-tree &>/dev/null || {
    git_async=""
    return
  }

  async_job git_worker git_worker_task "$PWD"
}

# Refresh git if a git command is executed
git_preexec_refresh() {
  if [[ "$1" == git* ]]; then
    Last_git_dir=""
  fi
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
add-zsh-hook preexec git_preexec_refresh

# -------------------------------------------------
# Prompt Function
# -------------------------------------------------
# 'readonly' is used to cache so it doesn't reload colors constantly
readonly PROMPT='${exit_status}${ssh_indicator}${privilege_indicator}${current_dir}${git_async}
%F{blue}  %f'
RPROMPT='${lang_indicator}'