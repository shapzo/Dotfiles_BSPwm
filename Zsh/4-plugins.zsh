#============================plugins========================
autoload -Uz compinit
if [[ ! -f ~/.zcompdump || ~/.zcompdump -nt ~/.zshrc ]]; then
    compinit
else
    compinit -C
fi

plug=(
    #"/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
    #"/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    #"/usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"
    #"/usr/share/zsh/plugins/sudo.plugin.zsh"
    #"/usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
    #"/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in "${plug[@]}"; do
    if [[ -f "$plugin" ]]; then
        source "$plugin"
    else
        echo "Error $plugin"
    fi
done

#============================== autosuggestion =================
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=true
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#7c7c7c,bg=#1e1e1e,underline"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *|rm *|sudo *|mv *|ls *"
ZSH_AUTOSUGGEST_COMPLETION_IGNORE="git *|npm *|pip *"

#============================== highlight ==========================
#ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[command]='fg=#bc9dee,bold'
#ZSH_HIGHLIGHT_STYLES[alias]='fg=#89b4fa,bold'
#ZSH_HIGHLIGHT_STYLES[path]='fg=#f080ff,underline'
#ZSH_HIGHLIGHT_STYLES[error]='fg=#f38ba8,bold'
#ZSH_HIGHLIGHT_STYLES[function]='fg=#89dceb'
#ZSH_HIGHLIGHT_STYLES[comment]='fg=#6c7086,italic'
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ff6e34,bold'
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#34ffaa,bold'
#ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#ff1100,bold'
#ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#f9e2af'
#ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#fab387'
#ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#35b11c'
#ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#b1811c'
#ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#1ca7b1'
#ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

# fast highlight
# example -> fast-theme base16
FAST_HIGHLIGHT_MAXLENGTH=200
zstyle ':fsh:*' use-chroma true
zstyle ':fsh:*' highlight-brackets true
zstyle ':fsh:layer:main' error '196,bold,standout'

#===================== autocomplete ==================
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
#zstyle ':autocomplete:tab:*' widget-style menu-select

#zstyle ':autocomplete:*' min-input 2
#zstyle ':autocomplete:*' list-lines 16
#zstyle ':autocomplete:*' groups enabled
#zstyle ':autocomplete:history:*' list-lines 16
#zstyle ':autocomplete:history:*' remove-all-dups yes
#zstyle ':autocomplete:files:*' list-lines 16
#zstyle ':autocomplete:files:*' hidden all