#=================================================================
# '########:::::'###:::::'######::'##::::'##:'########:::'######::
#  ##.... ##:::'## ##:::'##... ##: ##:::: ##: ##.... ##:'##... ##:
#  ##:::: ##::'##:. ##:: ##:::..:: ##:::: ##: ##:::: ##: ##:::..::
#  ########::'##:::. ##:. ######:: #########: ########:: ##:::::::
#  ##.... ##: #########::..... ##: ##.... ##: ##.. ##::: ##:::::::
#  ##:::: ##: ##.... ##:'##::: ##: ##:::: ##: ##::. ##:: ##::: ##:
#  ########:: ##:::: ##:. ######:: ##:::: ##: ##:::. ##:. ######::
# ........:::..:::::..:::......:::..:::::..::..:::::..:::......:::

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#aliases
alias cls='clear'
alias csl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias vi='nvim'

#lsd 
ls='lsd --group-dirs=first'
l='lsd -l --group-dirs=first'
ll='lsd -a --group-dirs=first'
la='lsd -lha --group-dirs=first'
lh='lsd -lh --group-dirs=first'

#eza / exa
e='eza --icons --group-directories-first'
ee='eza --icons --group-directories-first -l'
eee='eza --icons --group-directories-first -a'
ea='eza --icons --group-directories-first -alh'

#functios

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

# Delete files permanently
rmf(){
    scrub -p dod $1; shred -zun 10 -v $1
}

#powerline promt
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ];
	 then
		source /usr/share/powerline/bindings/bash/powerline.sh
fi

#depending on the distro the path may vary
#exmple: -> /usr/share/powerline/bash/powerline.sh
#
