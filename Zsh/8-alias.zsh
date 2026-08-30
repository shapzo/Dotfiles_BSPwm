#=========================Aliases======================
#----------------pacman / paru administration-----------------
alias -g cate='paru -Sg | sort -u'
alias -g cate1='paru -Sgg | sort -u'
alias -g search='paru -Sg | grep'
alias -g search1='paru -Sgg | grep'

alias -g dowpkg='pacman -Sw'
alias -g rem='paru -R'
alias -g rem1='paru -Rs'
alias -g rem2='paru -Rsc'

alias -g cach='sudo paccache -rvk 2'
alias -g vaccache='sudo pacman -Scc'
alias -g rmcahe='sudo paccache -r'

#-----------------------aliases----------------------
alias \
        cls='clear' \
        csl='clear' \
        nau='nautilus' \
        vi='nvim' \

alias -g \
        fa='fastfetch --config ~/.config/fastfetch/config.json' \
        clock='tty-clock -C 5 -b -t -c' \
        clockl='tty-clock -b -t -c | lolcat' \
        na='nano -0 -lmt'

alias -s \
        pdf='evince' \
        {png,jpg,jpeg,gif}='eog' \
        {mp4,mkv,mov}='mpv' \
        {mp3,flac}='lollipop' \
        md='mdcat' \
        py='python3' \
        {txt}='gnome-text-editor' \
        {py,js,lua,sh,zsh,json,rasi,ini,html,css}='nvim' \
        {xlsx,pptx,csv,docx,odt}='libreoffice'

if command -v lsd >/dev/null 2>&1; then
    # ls for lsd
    alias -g \
            ls='lsd --group-dirs=first' \
            l='lsd -l --group-dirs=first' \
            ll='lsd -a --group-dirs=first' \
            la='lsd -lha --group-dirs=first' \
            lh='lsd -lh --group-dirs=first'

elif command -v eza >/dev/null 2>&1; then
    # alias for eza
    alias -g \
            ls='eza --icons --group-directories-first' \
            l='eza --icons --group-directories-first -hl --smart-group' \
            ll='eza --icons --group-directories-first -a' \
            la='eza --icons --group-directories-first -ahlG --smart-group'

else
    # alias for ls
    alias \
            ls='ls --color=auto' \
            l='ls -lh' \
            ll='ls -rtlh' \
            la='ls -A'
fi

# config
alias -g \
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
alias -g \
        st='git status' \
        ad='git add' \
        pu='git push' \
        pl='git pull' \
        re='git remote add origin' \
        cl='git clone' \
        com='git commit -m'