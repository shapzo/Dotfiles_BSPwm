# __/\\\\\\\\\\\\\\\_____/\\\\\\\\\\\____/\\\________/\\\____/\\\\\\\\\____________/\\\\\\\\\_        
#  _\////////////\\\____/\\\/////////\\\_\/\\\_______\/\\\__/\\\///////\\\_______/\\\////////__       
#   ___________/\\\/____\//\\\______\///__\/\\\_______\/\\\_\/\\\_____\/\\\_____/\\\/___________      
#    _________/\\\/_______\////\\\_________\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\/_____/\\\_____________     
#     _______/\\\/____________\////\\\______\/\\\/////////\\\_\/\\\//////\\\____\/\\\_____________    
#      _____/\\\/_________________\////\\\___\/\\\_______\/\\\_\/\\\____\//\\\___\//\\\____________   
#       ___/\\\/____________/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____\//\\\___\///\\\__________  
#        __/\\\\\\\\\\\\\\\_\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\______\//\\\____\////\\\\\\\\\_ 
#         _\///////////////____\///////////_____\///________\///__\///________\///________\/////////__

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#change to shell: chsh user -s /bin/zsh

# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="random"

ENABLE_CORRECTION="true"

#plugins=(git)

#source $ZSH/oh-my-zsh.sh

export LANG=es_MX.UTF-8

#=========================History==========
HISTFILE=~/.zsh_history
HISTZISE=10000
SAVEHIST=10000
setopt appendhistory

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

#-----------------------utilities----------------------
alias \
        cls='clear' \
        csl='clear' \
        nau='nautilus' \
        nf='neofetch' \
        nfl='neofetch | lolcat' \
        clock='tty-clock -C 5 -b -t -c' \
        clockl='tty-clock -b -t -c | lolcat' \
        pdf='evince' \
        img='eog' \
        video='mplayer'

# ls for lsd
 alias \
        ll='lsd -lh --group-dirs=first' \
        l='lsd -l --group-dirs=first' \
        la='lsd -a --group-dirs=first' \
        lla='lsd -lha --group-dirs=first' \
        ls='lsd --group-dirs=first'

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
#Adjust the brightness of my screen, due to the driver XD and TLP because for the energy management of my laptop
light(){
    sudo chmod 777 /sys/class/backlight/amdgpu_bl0/brightness | sudo tlp start
}
#git functions
clon(){
    git clone $1
}
commit(){
    git commit -m $1
}
gitbspwm(){
    git add .
    git commit -m "BSPwm"
    git push origin main
}

#============================plugins========================
#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#hot keys
#zstyle ':autocomplete:tab:*' insert-unambiguous yes
#zstyle ':autocomplete:tab:*' widget-style menu-select
#zstyle ':autocomplete:*' min-input 2
#bindkey $key[up] up-line-or-history
#bindkey $key[down] down-line-or-history
