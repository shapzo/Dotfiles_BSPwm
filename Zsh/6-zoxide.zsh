#=============tool for learning routes=========================
eval "$(zoxide init zsh)"

# Jump to frequently used directories with content preview
#unalias z 2>/dev/null
zfz_zoxide() {
    local dir
    dir=$(zoxide query -l | fzf \
        --style=full --height=95% --pointer='' --layout=reverse --preview-window=right:49% \
        --padding='1,2' --layout=reverse-list --cycle \
        --bind 'alt-up:preview-up,alt-down:preview-down,ctrl-p:toggle-preview' \
        --color='pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold' \
        --input-label=' [ Search dir ] ' --color='input-border:blue,input-label:blue:bold' \
        --list-label=' [ History Zoxide ] ' --color='list-border:green,list-label:green:bold' \
        --preview-label=' [ Content dir ] ' --color='preview-border:magenta,preview-label:magenta:bold' \
        --preview 'eza --group-directories-first -T -L 2 --icons --color=always {} | head -50' \
        )

    if [[ -n "$dir" ]]; then
        cd "$dir"
        zle reset-prompt
    fi
}

# Search for files and open them directly in your preferred editor (nvim/vim)
## In Ubuntu/Debian and Derivatives change fd -> fdfind
## change bat -> batcat
fz_edit_file() {
    local file
    file=$(fd --type f --strip-cwd-prefix --hidden --exclude .git | fzf \
        --style=full --height=95% --pointer='' --layout=reverse --preview-window=right:49% \
        --padding='1,2' --layout=reverse-list --cycle \
        --multi --marker=' ' --color 'marker:green:bold' \
        --bind 'ctrl-s:toggle-down,ctrl-a:select-all,ctrl-d:deselect-all' \
        --bind 'alt-up:preview-up,alt-down:preview-down,ctrl-p:toggle-preview' \
        --color='pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold' \
        --input-label=' [ Find File ] ' --color='input-border:blue,input-label:blue:bold' \
        --list-label=' [ Files in Directory ] ' --color='list-border:green,list-label:green:bold' \
        --preview-label=' [ File Content ] ' --color='preview-border:magenta,preview-label:magenta:bold' \
        --preview 'bat -l yaml -p --color=always --style=numbers --line-range :500 {}' \
    )

    if [[ -n "$file" ]]; then
        # Open with your preferred editor, example -> atom "$file" &>/dev/null && disown
        ${EDITOR:-nvim} "$file"
        zle reset-prompt
    fi
}
