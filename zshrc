# __/\\\\\\\\\\\\\\\_____/\\\\\\\\\\\____/\\\________/\\\____/\\\\\\\\\____________/\\\\\\\\\_        
#  _\////////////\\\____/\\\/////////\\\_\/\\\_______\/\\\__/\\\///////\\\_______/\\\////////__       
#   ___________/\\\/____\//\\\______\///__\/\\\_______\/\\\_\/\\\_____\/\\\_____/\\\/___________      
#    _________/\\\/_______\////\\\_________\/\\\\\\\\\\\\\\\_\/\\\\\\\\\\\/_____/\\\_____________     
#     _______/\\\/____________\////\\\______\/\\\/////////\\\_\/\\\//////\\\____\/\\\_____________    
#      _____/\\\/_________________\////\\\___\/\\\_______\/\\\_\/\\\____\//\\\___\//\\\____________   
#       ___/\\\/____________/\\\______\//\\\__\/\\\_______\/\\\_\/\\\_____\//\\\___\///\\\__________  
#        __/\\\\\\\\\\\\\\\_\///\\\\\\\\\\\/___\/\\\_______\/\\\_\/\\\______\//\\\____\////\\\\\\\\\_ 
#         _\///////////////____\///////////_____\///________\///__\///________\///________\/////////__

#change to shell: chsh user -s /bin/zsh

#   if you use the themes of oh-my-zsh
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
setopt autocd
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort

autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#==================================================

#theme by powerlevel9k

#https://github.com/Powerlevel9k/powerlevel9k

#promt powerlevel9k
#source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
#source /path

#custom powerlevel 9k
#POWERLEVEL9K_MODE="nerdfont-complete"
#POWERLEVEL9K_DISABLE_RPROMPT=true
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" "
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_linux_icon dir vcs)

#POWERLEVEL9K_CUSTOM_LINUX_ICON="echo "
#POWERLEVEL9K_CUSTOM_LINUX_ICON_BACKGROUND=069
#POWERLEVEL9K_CUSTOM_LINUX_ICON_FOREGROUND=015

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
        fa='fastfetch --config ~/.config/fastfetch/config.json' \
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

# alias for exa
alias \
    e='exa' \
    ee='exa -lh --group-directories-first' \
    eee='exa -alh --group-directories-first'

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

#git functions
clon(){
    git clone $1
}
commit(){
    git commit -m $1
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

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Sudo
source /usr/share/zsh/plugins/sudo.plugin.zsh

#pywal theme
[[ -f ~/.cache/wal/colors.sh ]] && source ~/.cache/wal/colors.sh