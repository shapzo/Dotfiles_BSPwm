#: java jdbc
export CLASSPATH=$CLASSPATH:/usr/share/java/mariadb-jdbc.jar:/usr/share/java/jaybird-jdbc.jar

#: Pywal theme
#[[ -f ~/.cache/wal/colors.sh ]] && source ~/.cache/wal/colors.sh

#: Make FZF use fd by default (respects .gitignore and is faster)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

#: FZF (ctr + t)
export FZF_CTRL_T_OPTS="
    --style=full --height=95% --pointer '' --preview-window=right:65%
    --layout=reverse-list --cycle
    --multi --marker=' ' --color 'marker:green:bold'
    --bind 'ctrl-s:toggle-down,ctrl-a:select-all,ctrl-d:deselect-all'
    --bind 'alt-up:preview-up,alt-down:preview-down,ctrl-p:toggle-preview'
    --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold'
    --input-label ' [ Search ] ' --color 'input-border:blue,input-label:blue:bold'
    --list-label ' [ Files ] ' --color 'list-border:green,list-label:green:bold'
    --preview-label ' [ Preview ] ' --color 'preview-border:magenta,preview-label:magenta:bold'
    --preview 'bat -l yaml -p --color=always --style=numbers --line-range :500 {} 2>/dev/null || eza -1 --icons --color=always {}'"

#: FZF Ctrl+R (history)
export FZF_CTRL_R_OPTS="
    --style=full --height=60% --pointer ''
    --layout=reverse-list --cycle
    --bind 'ctrl-p:toggle-preview'
    --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold'
    --input-label ' [ Search ] ' --color 'input-border:blue,input-label:blue:bold'
    --list-label ' [ History ] ' --color 'list-border:green,list-label:green:bold'
    --preview 'echo {}' --preview-window 'down:3:wrap:hidden'"

#: FZF Alt+C (dirs)
export FZF_ALT_C_OPTS="
    --style=full --height=95% --pointer '' --preview-window=right:65%
    --layout=reverse-list --cycle
    --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold'
    --input-label ' [ Search ] ' --color 'input-border:blue,input-label:blue:bold'
    --list-label ' [ Dirs ] ' --color 'list-border:green,list-label:green:bold'
    --preview-label ' [ Content ] ' --color 'preview-border:magenta,preview-label:magenta:bold'
    --preview 'eza --group-directories-first -T -L 2 --icons --color=always {} | head -50'"