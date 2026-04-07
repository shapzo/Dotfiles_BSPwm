#====================================================================================
#      ___           ___           ___           ___           ___           ___     
#     /\  \         /\  \         /\  \         /\__\         /\  \         /\__\    
#    /::\  \       /::\  \       /::\  \       /::|  |       /::\  \       /::|  |   
#   /:/\:\  \     /:/\:\  \     /:/\:\  \     /:|:|  |      /:/\:\  \     /:|:|  |   
#  /::\~\:\  \   /::\~\:\  \   /:/  \:\  \   /:/|:|__|__   /::\~\:\  \   /:/|:|  |__ 
# /:/\:\ \:\__\ /:/\:\ \:\__\ /:/__/ \:\__\ /:/ |::::\__\ /:/\:\ \:\__\ /:/ |:| /\__\
# \/__\:\/:/  / \/__\:\/:/  / \:\  \  \/__/ \/__/~~/:/  / \/__\:\/:/  / \/__|:|/:/  /
#      \::/  /       \::/  /   \:\  \             /:/  /       \::/  /      |:/:/  / 
#       \/__/        /:/  /     \:\  \           /:/  /        /:/  /       |::/  /  
#                   /:/  /       \:\__\         /:/  /        /:/  /        /:/  /   
#                   \/__/         \/__/         \/__/         \/__/         \/__/    
#====================================================================================

# Exit if it is not an interactive shell
[[ $- == *i* ]] || return

# To avoid double echoing
# Basically helps zsh render everything: it reads first and then tells the prompt what to display
setopt prompt_subst
setopt extendedglob
#: Load module datatime and mathfunc
zmodload zsh/datetime
zmodload zsh/mathfunc
# Load hooks module
autoload -Uz add-zsh-hook
# Load zsh async
typeset -a asyncc=(
    "/usr/share/zsh/plugins/zsh-async/async.zsh"
)

for plugin in "$asyncc[@]"; do
    if [[ -f "$plugin" ]]; then
        source "$plugin"
    else
        [[ "$plugin" == *"async"* ]]
    fi
done

if (( $+functions[async_init] )); then
    async_init
else
    async_job() { :; } 
fi

# -------------------------------------------------
# Global Variables
# -------------------------------------------------
typeset -g exit_status=""
typeset -g ssh_indicator=""
typeset -g cmd_duration=""
typeset -g privilege_indicator=""
typeset -g lang_indicator=""
typeset -g last_lang_dir=""
typeset -g current_dir=""
typeset -g git_async=""
typeset -g last_git_dir=""

# ---- Git Icons ----
typeset -g GIT_ICON_ADDED="%F{#DB7500}✚ %f"
typeset -g GIT_ICON_MODIFIED="%F{#CF4EDE}✹ %f"
typeset -g GIT_ICON_DELETED="%F{#D60000}✖ %f"
typeset -g GIT_ICON_UNTRACKED="%F{#00e7b5}✭ %f"
typeset -g GIT_ICON_CLEAN="%F{#242424}  %f"
typeset -g GIT_ICON_DIRTY="%F{#ff0000} ✘ %f"
typeset -g GIT_ICON_RENAMED="%F{#f9e2af} ➜ %f"

# ---- Git Bubble ----
typeset -g GIT_PREFIX="%F{#006e0f}%K{#006e0f}%F{#000000}  %B"
typeset -g GIT_SUFFIX="%b%k%F{#006e0f}%f"

# ---- Prompt Bubble ----
typeset -g BG_PACMAN="#050505"
typeset -g BG_PATH="#06bbbb"
typeset -g BG_GHOSTS="#030303"
  
typeset -g SEP_OPEN="%F{$BG_PACMAN}"
typeset -g PACMAN="%F{yellow}%K{$BG_PACMAN} 󰮯 "
typeset -g CIRCLE="%F{#ffffff}"
typeset -g GHOST_1="%F{#05bbbb}󱙝"
typeset -g GHOST_2="%F{#ff960c}󱙝"
typeset -g GHOST_3="%F{#ff1b5f}󱙝"
typeset -g SEP_CLOSE="%F{$BG_GHOSTS}%k%f"

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
# Command Execution Timer
# -------------------------------------------------
# Runs BEFORE the command starts
prompt_preexec_timer() {
    cmd_timer=$EPOCHREALTIME
}

# Runs AFTER the command finishes
prompt_cmd_duration() {
    # Exit if timer wasn't started
    [[ -z "$cmd_timer" ]] && return
    
    # Calculate decimal difference
    local elapsed=$(( EPOCHREALTIME - cmd_timer ))
    unset cmd_timer
    
    # 0.3s Threshold: Only show if the command took a noticeable amount of time
    if (( elapsed >= 0.3 )); then
        local res=""
        
        if (( elapsed >= 3600 )); then
            # Format: 1h 20m
            local h=$(( int(elapsed / 3600) ))
            local m=$(( int((elapsed % 3600) / 60) ))
            res="${h}h ${m}m"
        elif (( elapsed >= 60 )); then
            # Format: 2m 15s
            local m=$(( int(elapsed / 60) ))
            local s=$(( int(elapsed % 60) ))
            res="${m}m ${s}s"
        else
            # Format: 2.45s (using printf for 2 decimal places)
            res="$(printf "%.2fs" $elapsed)"
        fi
        
        # Color: Peach (#fab387) with speed icon
        cmd_duration="%F{#fab387}󱦟 ${res}%f "
    else
        # Clear duration if below threshold
        cmd_duration=""
    fi
}

# -------------------------------------------------
# Function to detect Privileges (Root)
# -------------------------------------------------
prompt_privilege_indicator() {
  # If user ID is 0 (root)
  if [[ $UID -eq 0 ]]; then
    privilege_indicator="%F{red}%K{red}%F{white} 󰮯 %f%k%F{red}%f "
  else
    privilege_indicator=""
  fi
}

# -------------------------------------------------
# Function to detect Languages in the Directory
# -------------------------------------------------
prompt_lang_indicator() {
  [[ "$PWD" == "$last_lang_dir" ]] && return
  last_lang_dir="$PWD"
  lang_indicator=""
   # Python
  [[ -n *.py(#qN[1]) || -f "requirements.txt" || -f "pyproject.toml" ]] && lang_indicator+="%F{#3776AB} %f"
  # Rust
  [[ -n *.rs(#qN[1]) || -f "Cargo.toml" ]] && lang_indicator+="%F{#363636} %f"
  # C / C++
  [[ -n *.(c|cpp|h|hpp)(#qN[1]) ]] && lang_indicator+="%F{#00599C} %f"
  # JavaScript / TypeScript / Node
  [[ -n *.(js|ts|jsx|tsx)(#qN[1]) || -f "package.json" ]] && lang_indicator+="%F{#F7DF1E} %f"
  # Shell scripts
  [[ -n *.sh(#qN[1]) ]] && lang_indicator+="%F{#8F726F} %f"
  # HTML
  [[ -n *.(html|htm)(#qN[1]) ]] && lang_indicator+="%F{#E34F26} %f"
  # CSS
  [[ -n *.css(#qN[1]) ]] && lang_indicator+="%F{#1572B6} %f"
  # PHP
  [[ -n *.php(#qN[1]) ]] && lang_indicator+="%F{#9877B4} %f"
  # Java
  [[ -n *.java(#qN[1]) ]] && lang_indicator+="%F{#966E00} %f"
  # Go
  [[ -n *.go(#qN[1]) || -f "go.mod" ]] && lang_indicator+="%F{#00ADD8}󰟓 %f"
  # Lua
  [[ -n *.lua(#qN[1]) ]] && lang_indicator+="%F{#51B2E8} %f"
  # Ruby
  [[ -n *.rb(#qN[1]) || -f "Gemfile" ]] && lang_indicator+="%F{#CC342D} %f"
  # SQL
  [[ -n *.sql(#qN[1]) ]] && lang_indicator+="%F{#FFA11F} %f"
  # SQLite
  [[ -n *.(db|sqlite|sqlite3)(#qN[1]) ]] && lang_indicator+="%F{#0284C2} %f"
  # Docker
  [[ -f "Dockerfile" || -f "docker-compose.yml" ]] && lang_indicator+="%F{#2496ED} %f"
}

# -------------------------------------------------
# Git Function
# -------------------------------------------------
# Git "Worker" Function: Runs heavy Git operations in the background
git_worker_task() {
  local target_dir="$1"
  
  # 1. Fetch branch name or short hash (detached HEAD)
  local ref=$(git -C "$target_dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$target_dir" rev-parse --short HEAD 2>/dev/null)
  [[ -z $ref ]] && return # Bail if not a git repo

  local status_info=""
  local state_icon="$GIT_ICON_CLEAN"
  
  # 2. Get status in porcelain format (script-friendly)
  # Ignore submodules for maximum performance
  local git_status_output=$(git -C "$target_dir" status --porcelain --ignore-submodules 2>/dev/null)

  if [[ -n "$git_status_output" ]]; then
    state_icon="$GIT_ICON_DIRTY"
    
    # Use an associative array to track unique states
    # This prevents icon duplication when multiple files share the same status
    local -A seen=()
    local line
    while IFS= read -r line; do
      local xy="${line[1,2]}"   # Extract first two characters (X & Y status codes)
      case "$xy" in
        \?\?) seen[untracked]=1                      ;; # untracked file 
        A?)   seen[added]=1                          ;; # file added/staged for commit
        M?)   seen[staged_mod]=1                     ;; # file modified and staged
        MM)   seen[staged_mod]=1; seen[wt_mod]=1     ;; # modified in staging AND also modified in working tree
        \ M)  seen[wt_mod]=1                         ;; # modified only in working tree
        D?)   seen[staged_del]=1                     ;; # file deleted and staged
        \ D)  seen[wt_del]=1                         ;; # file deleted only in working tree
        R?)   seen[renamed]=1                        ;; # file renamed
      esac
    done <<< "$git_status_output"

    # 3. Assemble status icons based on discovered flags
    [[ -n ${seen[untracked]} ]] && status_info+="$GIT_ICON_UNTRACKED"
    [[ -n ${seen[added]} ]]     && status_info+="$GIT_ICON_ADDED"
    [[ -n ${seen[renamed]} ]]   && status_info+="$GIT_ICON_RENAMED"
    [[ -n ${seen[staged_mod]} || -n ${seen[wt_mod]} ]] && status_info+="$GIT_ICON_MODIFIED"
    [[ -n ${seen[staged_del]} || -n ${seen[wt_del]} ]] && status_info+="$GIT_ICON_DELETED"
  fi

   # 4. Return block git
  local result="${GIT_PREFIX}${ref}${state_icon}${status_info}${GIT_SUFFIX}"
  print -nr -- "$result"
}

# Callback: Triggered when the async worker finishes
git_callback() {
  local output="$3"
  
  # Clear variable and reset prompt if output is empty
  if [[ -z $output ]]; then
    [[ -n $git_async ]] && { git_async=""; zle && zle reset-prompt; }
    return
  fi
  
  # Only reset prompt if the Git status string has actually changed
  if [[ "$git_async" != "$output" ]]; then
    git_async="$output"
    zle && zle reset-prompt
  fi
}

# Initialize Async Worker
if (( $+functions[async_start_worker] )); then
    async_start_worker git_worker -n
    async_register_callback git_worker git_callback
fi

# Trigger Hook: Decides when to spawn a new async job
prompt_trigger_async() {
  # Skip if directory hasn't changed to save resources
  [[ "$PWD" == "$last_git_dir" ]] && return
  last_git_dir="$PWD"

  # Check if we are inside a Git work tree
  git -C "$PWD" rev-parse --is-inside-work-tree &>/dev/null || {
    git_async=""
    return
  }
  # Dispatch job to worker
  async_job git_worker git_worker_task "$PWD"
}

# Pre-execution Hook: Forces a refresh after running any command (like 'git add')
git_preexec_refresh() {
  last_git_dir=""
}

# -------------------------------------------------
# Main Prompt Function
# -------------------------------------------------
prompt_current_dir() {
  local dir_text=" %U%B%2~%b%u"
  local DIR_BLOCK="%F{$BG_PACMAN}%K{$BG_PATH}%F{black} $dir_text %F{$BG_PATH}%K{$BG_GHOSTS}"

  #[[  -z ${PWD#$HOME}  ]] -> this would be another way but I like this one for now
  if [[ "$PWD" == "$HOME" ]]; then
    # Home: Pacman and dots only
    current_dir="$SEP_OPEN$PACMAN%F{$BG_PACMAN}%K{$BG_GHOSTS}%F{#ffffff}$CIRCLE $CIRCLE $CIRCLE $GHOST_1 $SEP_CLOSE"
  else
    # Outside Home: Includes current folder (%2~) to show the last 2 directories relative to home (could also use 2c)
    current_dir="$SEP_OPEN$PACMAN$DIR_BLOCK $GHOST_1 $GHOST_2 $GHOST_3 $SEP_CLOSE"
  fi
}

# Prompt
set_full_prompt() {
  PROMPT='${exit_status}${privilege_indicator}${current_dir}${git_async:+ ${git_async}}
 %F{blue}  %f'
  if (( COLUMNS >= 80 )); then
    RPROMPT='${cmd_duration}${lang_indicator}${ssh_indicator}'
  else
    RPROMPT=""
  fi
}

zle-line-finish() {
  if [[ -n "$exit_status" ]]; then
    PROMPT="%F{red}  󰮯 %F{#A6A6A6}%U%1~%u %F{#05FA63}󰊠 %f ${cmd_duration}%F{blue} %f"
  else
    PROMPT="%F{yellow}  󰮯 %F{#A6A6A6}%U%1~%u %F{#05FA63}󰊠 %f ${cmd_duration}%F{blue} %f"
  fi
  RPROMPT=""
  [[ -o zle ]] && zle reset-prompt
}
zle -N zle-line-finish

# -------------------------------------------------
# HOOK REGISTRATION
# -------------------------------------------------
prompt_precmd(){
  prompt_exit_status
  prompt_ssh_indicator
  prompt_cmd_duration
  prompt_privilege_indicator
  prompt_current_dir
  prompt_trigger_async
  set_full_prompt
}
add-zsh-hook precmd prompt_precmd
add-zsh-hook chpwd prompt_lang_indicator
add-zsh-hook preexec prompt_preexec_timer
