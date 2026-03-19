#===========================function's=================
#Delete files permanently
rmf(){
    if [[ -d $1 ]]; then
        echo "Error: $1 it is a directory."
        return 1
    fi
    scrub -p dod "$1" && shred -zun 10 -v "$1"
}
#Asciinema
rec(){
        asciinema rec "$@"
}
play(){
        asciinema play "$@"
}
#Funcion tree using lsd
tree(){
        lsd --group-dirs=first --tree "$@"
}
#Function using eza
et(){
        eza --icons --group-directories-first -T "$@"
}
eth(){
        eza --icons --group-directories-first -ahlg -T "$@"
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
            echo "no supported: $file" >&2
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
# Make directoris an cd
mkcd() {
    mkdir -p "$@" && cd "$_"
}
# Renamed files
rena() {
    local name="$1"
    local i=1

    if [[ -z "$name" ]]; then
        echo "Use: rena <nom>"
        return 1
    fi

    for f in *; do
        [[ -f "$f" ]] || continue
        local ext="${f##*.}"
        mv "$f" "${name} (${i}).${ext}"
        ((i++))
    done

    echo "${i-1} as '${name} (N).ext'"
}
