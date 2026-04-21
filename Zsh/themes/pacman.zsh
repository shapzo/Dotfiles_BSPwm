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

typeset -g GIT_ICON_REBASE="%F{#fab387}󰦗 %f"
typeset -g GIT_ICON_MERGE="%F{#89b4fa}󰃸 %f"
typeset -g GIT_ICON_CONFLICT="%F{#f38ba8}⚔ %f"
typeset -g GIT_ICON_CHERRY="%F{#f9e2af} %f"
typeset -g GIT_ICON_REVERT="%F{#a6e3a1} %f"
typeset -g GIT_ICON_BISECT="%F{#cba6f7}󰃷 %f"

# ---- Cache Git ----
typeset -gA GIT_CACHE
typeset -gA GIT_CACHE_TIME
typeset -g last_async_time=0

# ---- Branch git ----
typeset -gA GIT_BRANCH_CACHE

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
    
    # 0.2s Threshold: Only show if the command took a noticeable amount of time
    if (( elapsed >= 0.2 )); then
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
#funtion detect git repo
_find_git_root() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        [[ -d "$dir/.git" || -f "$dir/.git" ]] && return 0
        dir="${dir:h}"
    done
    return 1
}
# Limpiar cache viejo (cada cierto tiempo)
clean_git_cache() {
  local now=$EPOCHSECONDS
  for dir in ${(k)GIT_CACHE_TIME}; do
    (( now - GIT_CACHE_TIME[$dir] > 300 )) && {
      unset "GIT_CACHE[$dir]"
      unset "GIT_CACHE_TIME[$dir]"
    }
  done
}

#funtion on detec branch
get_git_branch_fast() {
  git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null
}
check_git_branch_change() {
  _find_git_root || return
  local current_branch=$(get_git_branch_fast)
  local cached_branch=${GIT_BRANCH_CACHE[$PWD]}

  if [[ "$current_branch" != "$cached_branch" ]]; then
    unset "GIT_CACHE[$PWD]"
    unset "GIT_CACHE_TIME[$PWD]"
    GIT_BRANCH_CACHE[$PWD]="$current_branch"
  fi
}

# Git "Worker" Function: Runs heavy Git operations in the background
git_worker_task() {
  local target_dir="$1"
  
  # 1. Fetch branch name or short hash (detached HEAD)
  local ref=$(git -C "$target_dir" symbolic-ref --short HEAD 2>/dev/null || git -C "$target_dir" rev-parse --short HEAD 2>/dev/null)
  [[ -z $ref ]] && return # Bail if not a git repo

  local status_info=""
  local state_icon="$GIT_ICON_CLEAN"
  local remote_info=""
  local stash_info=""

  local repo_dir="$target_dir/.git"
  [[ -f "$repo_dir" ]] && repo_dir=$(git -C "$target_dir" rev-parse --git-dir 2>/dev/null)
  local special_state=""
  # REBASE
  if [[ -d "$repo_dir/rebase-merge" || -d "$repo_dir/rebase-apply" ]]; then
    special_state+="$GIT_ICON_REBASE"
  fi
  # MERGE
  if [[ -f "$repo_dir/MERGE_HEAD" ]]; then
    special_state+="$GIT_ICON_MERGE"
  fi
  # CHERRY-PICK
  if [[ -f "$repo_dir/CHERRY_PICK_HEAD" ]]; then
    special_state+="$GIT_ICON_CHERRY"
  fi
  # REVERT
  if [[ -f "$repo_dir/REVERT_HEAD" ]]; then
    special_state+="$GIT_ICON_REVERT"
  fi
  # BISECT
  if [[ -f "$repo_dir/BISECT_LOG" ]]; then
    special_state+="$GIT_ICON_BISECT"
  fi
  
  # 2. Get status in porcelain format (script-friendly)
  # Ignore submodules for maximum performance
  local git_status_output=$(git -C "$target_dir" status --porcelain --ignore-submodules=dirty --untracked-files=normal 2>/dev/null)

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
        MM)   seen[staged_mod]=1; seen[wt_mod]=1     ;; # modified in staging AND also modified in working tree
        M?)   seen[staged_mod]=1                     ;; # file modified and staged
        \ M)  seen[wt_mod]=1                         ;; # modified only in working tree
        D?)   seen[staged_del]=1                     ;; # file deleted and staged
        \ D)  seen[wt_del]=1                         ;; # file deleted only in working tree
        R?)   seen[renamed]=1                        ;; # file renamed
        UU)   seen[conflict]=1  ;; # Conflicts
      esac
    done <<< "$git_status_output"

    # 3. Assemble status icons based on discovered flags
    [[ -n ${seen[untracked]} ]] && status_info+="$GIT_ICON_UNTRACKED"
    [[ -n ${seen[conflict]} ]] && status_info+="$GIT_ICON_CONFLICT"
    [[ -n ${seen[added]} ]]     && status_info+="$GIT_ICON_ADDED"
    [[ -n ${seen[renamed]} ]]   && status_info+="$GIT_ICON_RENAMED"
    [[ -n ${seen[staged_mod]} || -n ${seen[wt_mod]} ]] && status_info+="$GIT_ICON_MODIFIED"
    [[ -n ${seen[staged_del]} || -n ${seen[wt_del]} ]] && status_info+="$GIT_ICON_DELETED"
  fi

  # Stash
  local stash_count=$(git -C "$target_dir" rev-list --walk-reflogs --count refs/stash 2>/dev/null || echo 0)
  (( stash_count > 0 )) && stash_info="%F{#fab387} ${stash_count}%f "


  # Remote status
  local upstream=$(git -C "$target_dir" rev-parse --abbrev-ref @{upstream} 2>/dev/null)
  if [[ -n "$upstream" ]]; then
    local ahead=$(git -C "$target_dir" rev-list @{upstream}..HEAD --count 2>/dev/null)
    local behind=$(git -C "$target_dir" rev-list HEAD..@{upstream} --count 2>/dev/null)
    (( ahead  > 0 )) && remote_info+="%F{#a6e3a1} ${ahead}%f "
    (( behind > 0 )) && remote_info+="%F{#f38ba8} ${behind}%f "
  fi

   # 4. Return block git
  print -nr -- "${GIT_PREFIX}${ref}${state_icon}${stash_info}${remote_info}${special_state}${status_info}${GIT_SUFFIX}"
}

# Callback: Triggered when the async worker finishes
git_callback() {
  local output="$3"
  local target_dir="$5" 

  if [[ -n $output ]]; then
    GIT_CACHE[$target_dir]="$output"
    GIT_CACHE_TIME[$target_dir]=$EPOCHSECONDS
    
    if [[ "$git_async" != "$output" ]]; then
      git_async="$output"
      zle && zle reset-prompt
    fi
  else
    if [[ -n "$git_async" ]]; then
      git_async=""
      zle && zle reset-prompt
    fi
  fi
}

# Initialize Async Worker
if (( $+functions[async_start_worker] )); then
    async_start_worker git_worker -n
    async_register_callback git_worker git_callback
fi

# Trigger Hook: Decides when to spawn a new async job
prompt_trigger_async() {
  local now=$EPOCHSECONDS

  # 1. Recent Cache: Use directly if available and fresh
  if (( ${+GIT_CACHE[$PWD]} )); then
    local last_time=${GIT_CACHE_TIME[$PWD]:-0}
    if (( now - last_time < 2 )); then
      git_async="${GIT_CACHE[$PWD]}"
      return
    fi
  fi

  # 2. Throttle: Limit to one worker per second in the same directory to save resources
  (( now - last_async_time < 1 )) && [[ "$PWD" == "$last_git_dir" ]] && return
  last_async_time=$now
  last_git_dir="$PWD"

  # 3. Git Check: Verify if the current directory is inside a Git work tree
  _find_git_root || {
    git_async=""
    return
  }

  # 4. Async Execution: Dispatch the task to the git_worker
  async_job git_worker git_worker_task "$PWD"
}

# Pre-execution Hook: Forces a refresh after running any command (like 'git add')
git_preexec_refresh() {
  last_git_dir=""
  if [[ "$1" == git(|\ *) ]]; then
    unset "GIT_CACHE[$PWD]"
    unset "GIT_CACHE_TIME[$PWD]"
  fi
}

# -------------------------------------------------
# Main Prompt Function
# -------------------------------------------------
prompt_current_dir() {
  local PACMAN_ICON
  if [[ $UID -eq 0 ]]; then
    PACMAN_ICON="%F{#FF0000}%K{$BG_PACMAN} 󰮯 "
  else
    PACMAN_ICON="$PACMAN"
  fi

  # function normal
  local dir_text=" %U%B%2~%b%u"
  local DIR_BLOCK="%F{$BG_PACMAN}%K{$BG_PATH}%F{black} $dir_text %F{$BG_PATH}%K{$BG_GHOSTS}"

  #[[  -z ${PWD#$HOME}  ]] -> this would be another way but I like this one for now
  if [[ "$PWD" == "$HOME" ]]; then
    # Home: Pacman and dots only
    current_dir="$SEP_OPEN${PACMAN_ICON}%F{$BG_PACMAN}%K{$BG_GHOSTS}%F{#ffffff}$CIRCLE $CIRCLE $CIRCLE $GHOST_1 $SEP_CLOSE"
  else
    # Outside Home: Includes current folder (%2~) to show the last 2 directories relative to home (could also use 2c)
    current_dir="$SEP_OPEN${PACMAN_ICON}$DIR_BLOCK $GHOST_1 $GHOST_2 $GHOST_3 $SEP_CLOSE"
  fi
}

# Prompt
set_full_prompt() {
  PROMPT='${exit_status}${current_dir}${git_async:+ ${git_async}}
 %F{blue}  %f'
  if (( COLUMNS >= 80 )); then
    RPROMPT='${cmd_duration}${lang_indicator}${ssh_indicator}'
  else
    RPROMPT=""
  fi
}

zle-line-finish() {
  local dir_alter="%F{blue} %f"
  if [[ -n "$exit_status" ]]; then
    PROMPT="%F{red}  󰮯 %F{#A6A6A6}%U%1~%u %F{#05FA63}󰊠 %f ${cmd_duration}$dir_alter"
  else
    PROMPT="%F{yellow}  󰮯 %F{#A6A6A6}%U%1~%u %F{#05FA63}󰊠 %f ${cmd_duration}$dir_alter"
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
  prompt_current_dir
  check_git_branch_change
  prompt_trigger_async
  if (( EPOCHSECONDS - ${GIT_LAST_CLEAN:-0} > 20 )); then
    GIT_LAST_CLEAN=$EPOCHSECONDS
    clean_git_cache
  fi
  set_full_prompt
}
add-zsh-hook precmd prompt_precmd
add-zsh-hook chpwd prompt_lang_indicator
add-zsh-hook preexec git_preexec_refresh
add-zsh-hook preexec prompt_preexec_timer