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
        --preview '
            if [ -d {} ]; then
                eza --group-directories-first -T -L 2 --icons --color=always {} | head -50
            else
                bat --color=always {}
            fi' \
        )

    if [[ -n "$dir" ]]; then
        cd "$dir"
        zle reset-prompt
    fi
}
zle -N zfz_zoxide
bindkey '^z' zfz_zoxide

# normal zoxide
alias zii='zi'
bindkey -s '^o' 'zii\n'