#========================== FZF =================================
# --- FZF load ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zstyle ':fzf-tab:*' fzf-flags \
                --style=full --height=95% --pointer '' --preview-window=right:65% \
                --padding='1,2' --layout=reverse-list --cycle \
                --multi --marker='󰄬 ' --color 'marker:green:bold' \
                --bind 'ctrl-s:toggle-down,ctrl-a:select-all,ctrl-d:deselect-all' \
                --bind 'alt-up:preview-up,alt-down:preview-down,ctrl-p:toggle-preview' \
                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold' \
                --input-label ' [ Search ] ' --color 'input-border:blue,input-label:blue:bold' \
                --list-label ' [ Results ] ' --color 'list-border:green,list-label:green:bold' \
                --preview-label ' [ Preview ] ' --color 'preview-border:magenta,preview-label:magenta:bold'

# --- Shortcuts and Behavior ---

# Preview for specific commands
zstyle ':fzf-tab:complete:cd:*'  fzf-preview 'eza -1 --icons --group-directories-first --color=always -hl --smart-group --no-filesize $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --line-range :500 $realpath 2>/dev/null || eza -1 --icons --group-directories-first --color=always -hl --smart-group --no-filesize $realpath 2>/dev/null'

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

# Preview contents of .zip, .odt, etc.
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  case $realpath in
    *.tar*|*.tgz) tar -tvf "$realpath" ;;
    *.zip) unzip -l "$realpath" ;;
    *.rar) unrar l "$realpath" ;;
    *.docx|*.odt) pandoc "$realpath" ;;
    *.md) mdcat --columns=50 -p "$realpath" ;;
    *)

    if [[ -d $realpath ]]; then
        eza -1 --icons --group-directories-first --color=always -hl --smart-group --no-filesize "$realpath"
    else
        bat --color=always --line-range :500 "$realpath" 2>/dev/null || cat "$realpath"
    fi ;;
  esac'

# FZF-Tab Package Completion (Pacman/Paru) usig pacman -Fl and  pacman -Si
#zstyle ':fzf-tab:complete:(pacman|paru):*' fzf-preview \
#    '{ pacman -Si $word 2>/dev/null; echo -e "\nFILES:"; pacman -Fl $word 2>/dev/null | awk "NF>1{print $2}" } | bat -l yaml -p --color=always'
#zstyle ':fzf-tab:complete:(pacman|paru):*' fzf-flags \
#                --style=full --height=95% --pointer '' \
#                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold' \
#                --input-label ' Search ' --color 'input-border:blue,input-label:blue:bold' \
#                --list-label ' Packages ' --color 'list-border:green,list-label:green:bold' \
#                --preview-label ' Describcion ' --color 'preview-border:magenta,preview-label:magenta:bold'

# FZF-Tab Package Completion Pacman usig expac
zstyle ':fzf-tab:complete:pacman:*' fzf-preview \
    'bash $HOME/.config/zsh/pkg_preview.sh $word | bat -l yaml -p --color=always'

zstyle ':fzf-tab:complete:pacman:*' fzf-flags \
        --style=full --height=95% --pointer '' --preview-window=right:65%:hidden \
        --padding='1,2' --layout=reverse-list --cycle \
        --multi --marker='󰄬 ' --color 'marker:green:bold' \
        --bind 'ctrl-s:toggle-down,ctrl-a:select-all,ctrl-d:deselect-all' \
        --bind 'alt-up:preview-up,alt-down:preview-down,ctrl-p:toggle-preview' \
        --color 'pointer:green:bold,bg+:-1:,fg+:green:bold' \
        --input-label ' [ Search ] ' --color 'input-border:blue,input-label:blue:bold' \
        --list-label ' [ Pkgs ] ' --color 'list-border:green,list-label:green:bold' \
        --preview-label ' [ Descripcion ] ' --color 'preview-border:magenta,preview-label:magenta:bold'

# fzf shortcuts
#alias cdfz='cd $(fd -t d -H . 2>/dev/null | fzf --height 40% --reverse || find . -maxdepth 3 -type d 2>/dev/null | fzf)'
alias gitfz='git log --oneline | fzf --preview "git show --color=always {1}" | cut -d" " -f1 | xargs -r git show'