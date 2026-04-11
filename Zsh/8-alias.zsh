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
        fa='fastfetch --config ~/.config/fastfetch/config.json' \
        clock='tty-clock -C 5 -b -t -c' \
        clockl='tty-clock -b -t -c | lolcat' \
        pdf='evince' \
        img='eog' \
        vi='nvim' \
        video='mplayer' \
        dm='mdcat' \
        na='nano -0 -lmt'

if command -v lsd >/dev/null 2>&1; then
    # ls for lsd
    alias \
            ls='lsd --group-dirs=first' \
            l='lsd -l --group-dirs=first' \
            ll='lsd -a --group-dirs=first' \
            la='lsd -lha --group-dirs=first' \
            lh='lsd -lh --group-dirs=first'

elif command -v eza >/dev/null 2>&1; then
    # alias for eza
    alias \
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
        pull='git pull' \
        remote='git remote add origin' \
        clon='git clone' \
        commit='git commit -m'