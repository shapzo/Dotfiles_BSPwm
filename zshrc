#!/usr/bin/env zsh
# __/\\\\\\\\\\\\\\\_____/\\\\\\\\\\\____/\\\________/\\\____/\\\\\\\\\____________/\\\\\\\\\_        
#  _\////////////\\\____/\\\/////////\\\_\/\\\_______\/\\\__/\\\///////\\\_______/\\\////////__       
#   ___________/\\\/____\//\\\______\///__\/\\\_______\/\\\_\/\\\_____\/\\\_____/\\\/___________      
#    _________/\\\/_______\////\\\_________\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\/_____/\\\_____________     
#     _______/\\\/____________\////\\\______\/\\\/////////\\\_\/\\\//////\\\____\/\\\_____________    
#      _____/\\\/_________________\////\\\___\/\\\_______\/\\\_\/\\\____\//\\\___\//\\\____________   
#       ___/\\\/____________/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____\//\\\___\///\\\__________  
#        __/\\\\\\\\\\\\\\\_\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\______\//\\\____\////\\\\\\\\\_ 
#         _\///////////////____\///////////_____\///________\///__\///________\///________\/////////__

#change to shell: chsh user -s /bin/zsh

# If you use the themes of oh-my-zsh
# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="random"

export EDITOR=nvim
export VISUAL=nvim

#plugins=(git)

#source $ZSH/oh-my-zsh.sh

#export LANG=es_MX.UTF-8
setopt prompt_subst
setopt autocd
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path "${HOME}/.zsh/cache"

# tool for learning routes
eval "$(zoxide init zsh)"

#=========================keybindings====================
bindkey '^U' backward-kill-line     # Ctrl + U
bindkey '^[[3;5~' kill-word         # Ctrl + Delete
bindkey '^[[3~' delete-char         # Delete
bindkey '^[[1;3D' backward-word     # Move backward word by word (Ctrl + Left Arrow)
bindkey '^[[1;3C' forward-word      # Move forward word by word (Ctrl + Right Arrow)

#=========================History==========
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

#==================================================
#theme by powerlevel9k

#https://github.com/Powerlevel9k/powerlevel9k

#promt powerlevel9k
#source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
#source /path

#custom powerlevel 9k
#POWERLEVEL9K_MODE="nerdfont-complete"
#POWERLEVEL9K_DISABLE_RPROMPT=true
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" "
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_linux_icon dir vcs)

#POWERLEVEL9K_CUSTOM_LINUX_ICON="echo "
#POWERLEVEL9K_CUSTOM_LINUX_ICON_BACKGROUND=069
#POWERLEVEL9K_CUSTOM_LINUX_ICON_FOREGROUND=015

#=========================Aliases======================
#----------------pacman / paru administration-----------------
alias cate='paru -Sg | sort -u'
alias cate1='paru -Sgg | sort -u'
alias search='paru -Sg | grep'
alias search1='paru -Sgg | grep'

alias dowpkg='pacman -Sw'
alias rem='paru -R'
alias rem1='paru -Rs'
alias rem2='paru -Rsc'

alias cach='sudo paccache -rvk 2'
alias vaccache='sudo pacman -Scc'
alias rmcahe='sudo paccache -r'

#-----------------------aliases----------------------
alias \
        cls='clear' \
        csl='clear' \
        nau='nautilus' \
        nf='neofetch' \
        nfl='neofetch | lolcat' \
        fa='fastfetch --config ~/.config/fastfetch/config.json' \
        clock='tty-clock -C 5 -b -t -c' \
        clockl='tty-clock -b -t -c | lolcat' \
        pdf='evince' \
        img='eog' \
        video='mplayer' \
        dm='mdcat' \
        na='nano -0 -l -m -t' \

# ls for lsd
 alias \
        ls='lsd --group-dirs=first' \
        l='lsd -l --group-dirs=first' \
        ll='lsd -a --group-dirs=first' \
        la='lsd -lha --group-dirs=first' \
        lh='lsd -lh --group-dirs=first'

# alias for eza
alias \
        e='eza --icons --group-directories-first' \
        ee='eza --icons --group-directories-first -hlg' \
        eee='eza --icons --group-directories-first -a' \
        ea='eza --icons --group-directories-first -ahlg'

# config
alias \
        z='vi ~/.zshrc' \
        b='vi ~/.config/bspwm' \
        s='vi ~/.config/sxhkd/sxhkdrc' \
        p1='vi ~/.config/polybar/poly1' \
        p2='vi ~/.config/polybar/poly2' \
        p3='vi ~/.config/polybar/poly3' \
        p4='vi ~/.config/polybar/poly4' \
        r='vi ~/.config/rofi/themes' \
        k='vi ~/.config/kitty'

# git
alias \
        status='git status' \
        add='git add .' \
        push='git push origin main' \
        pull='git pull origin' \
        remote='git remote add origin'

#===========================function's=================
#Delete files permanently
rmf(){
    scrub -p dod $1; shred -zun 10 -v $1
}
#Open neovim
vi(){
    nvim $1
}

#Asciinema
rec(){
        asciinema rec $1
}
play(){
        asciinema play $1
}

#Funcion tree using lsd
tree(){
        lsd --group-dirs=first --tree $1
}

#Function using eza
et(){
        eza --icons --group-directories-first -T $1
}
eth(){
        eza --icons --group-directories-first -ahlg -T $1
}

# function extract
extract() {
    if command -v dtrx &> /dev/null; then
        dtrx "$@"
    else
        echo "Extract using manual method..."
    fi
}

extrac() {
    local file="$1"

    if [[ ! -f "$file" ]]; then
        echo "'$file' no file" >&2
        return 1
    fi

    local filename="${file##*/}"
    local dirname="${filename%%.*}"

    mkdir -p "$dirname" || return 1

    case "$file" in
        *.tar.bz2|*.tbz2) tar xjf "$file" -C "$dirname" ;;
        *.tar.gz|*.tgz)   tar xzf "$file" -C "$dirname" ;;
        *.tar.xz|*.txz)   tar xJf "$file" -C "$dirname" ;;
        *.tar.zst|*.tzst) tar -I zstd -xf "$file" -C "$dirname" ;;
        *.tar)            tar xf "$file" -C "$dirname" ;;
        *.zip|*.ZIP)      unzip "$file" -d "$dirname" ;;
        *.rar)            unrar x "$file" "$dirname/" ;;
        *.7z)             7z x "$file" -o"$dirname" ;;
        *.gz)             gunzip -k "$file" ;;
        *.bz2)            bunzip2 -k "$file" ;;
        *.xz)             unxz -k "$file" ;;
        *.zst)            unzstd -k "$file" ;;
        *)
            echo "no soported: $file" >&2
            return 1
            ;;
    esac

    [[ $? -eq 0 ]] && echo "Extract in ./$dirname"
}

# History search
hist() {
    grep -r "$1" ~/.zsh_history | tail -20
}

# Search files by name
f() {
    find . -type f -name "*$1*" 2>/dev/null
}

# Search in files by content
grepf() {
    grep -r "$1" . --include="*.$2" 2>/dev/null
}

#git functions
clon(){
    git clone $1
}
commit(){
    git commit -m $1
}

#============================plugins========================
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

plug=(
    #"/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
    "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    #"/usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"
    "/usr/share/zsh/plugins/sudo.plugin.zsh"
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plug[@]}"; do
    if [[ -f "$plugin" ]]; then
        source "$plugin"
    else
        echo "Error $plugin"
    fi
done

#========================== FZF =================================
# --- FZF load ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle ':fzf-tab:*' fzf-flags --style=full --height=95% --pointer '' \
                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold' \
                --input-label ' Search ' --color 'input-border:blue,input-label:blue:bold' \
                --list-label ' Results ' --color 'list-border:green,list-label:green:bold' \
                --preview-label ' Preview ' --color 'preview-border:magenta,preview-label:magenta:bold'

# --- Shortcuts and Behavior ---

# Preview for specific commands
zstyle ':fzf-tab:complete:cd:*'  fzf-preview 'eza -1 --icons --color=always -a $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --line-range :500 $realpath 2>/dev/null || eza -1 --icons --color=always $realpath 2>/dev/null'

# For environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-):*' fzf-preview 'echo ${(P)word}'

# For the kill command (See processes)
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'

# To accept with spaces
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'

# Disable auto-completion for groups if there is only one option
zstyle ':fzf-tab:*' group-colors A=92 B=93 C=94 D=95
zstyle ':fzf-tab:*' switch-group '<' '>'

# Preview the help for the flags/options of the commands
zstyle ':fzf-tab:complete:*:options' fzf-preview 'zsh -c "man $word" 2>/dev/null | col -bx | bat -l man -p --color=always'

# Preview contents of .zip, .tar, etc.
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  case $realpath in
    *.tar*|*.tgz) tar -tvf "$realpath" ;;
    *.zip) unzip -l "$realpath" ;;
    *.rar) unrar l "$realpath" ;;
    *) bat --color=always --line-range :500 "$realpath" 2>/dev/null || eza -1 --icons --color=always "$realpath" ;;
  esac'

# fzf shortcuts
alias cdfz='cd $(fd -t d -H . 2>/dev/null | fzf --height 40% --reverse || find . -maxdepth 3 -type d 2>/dev/null | fzf)'
alias fzfg='git log --oneline | fzf --preview "git show --color=always {1}" | cut -d" " -f1 | xargs -r git show'

# Jump to frequently used directories with content preview
unalias z 2>/dev/null
cdf() {
    local dir
    dir=$(zoxide query -l | fzf --height 70% --layout=reverse --preview 'eza -T -L 2 --icons --color=always {} | head -20') && cd "$dir"
}

#============================== autosuggestion =================
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7c7c7c,bg=#1e1e1e"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#============================== highlight ==========================
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#bc9dee,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=#f080ff,underline'
ZSH_HIGHLIGHT_STYLES[error]='fg=#f38ba8,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=#89dceb'

#===================== autocomplete ==================
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
#zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
zstyle ':autocomplete:*' list-lines 16
zstyle ':autocomplete:*' groups enabled
zstyle ':autocomplete:history:*' list-lines 16
zstyle ':autocomplete:history:*' remove-all-dups yes
zstyle ':autocomplete:files:*' list-lines 16
zstyle ':autocomplete:files:*' hidden all 

#pywal theme
#[[ -f ~/.cache/wal/colors.sh ]] && source ~/.cache/wal/colors.sh

#powerline promt
#if [ -f /usr/share/powerline/bindings/zsh/powerline.zsh ];
#         then
#                source /usr/share/powerline/bindings/zsh/powerline.zsh
#fi

# java jdbc
export CLASSPATH=$CLASSPATH:/usr/share/java/mariadb-jdbc.jar:/usr/share/java/jaybird-jdbc.jar