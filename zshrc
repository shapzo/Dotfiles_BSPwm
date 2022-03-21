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

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="random"

ENABLE_CORRECTION="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=es_MX.UTF-8

#=========================History==========
HISTFILE=~/.zsh_history
HISTZISE=10000
SAVEHIST=10000
setopt appendhistory

#=========================Aliases======================
#----------------pacman / paru administration-----------------
alias cate="paru -Sg | sort -u"
alias cate1="paru -Sgg | sort -u"
alias search="paru -Sg | grep"
alias search1="paru -Sgg | grep"

alias dowpkg="pacman -Sw"
alias rem="paru -R"
alias rem1="paru -Rs"
alias rem2="paru -Rsc"

alias cach="sudo paccache -rvk 2"
alias vaccache="sudo pacman -Scc"
alias rmcahe="sudo paccache -r"

#-----------------------utilities----------------------
alias cls="clear"
alias csl="clear"

alias nau="nautilus"
alias nf="neofetch"
alias nfl="neofetch | lolcat"
alias pdf="evince"
alias img="eog"
alias video="mplayer"

alias b="vi ~/.config/bspwm/bspwmrc"
alias s="vi ~/.config/sxhkd/sxhkdrc"
alias z="vi ~/.zshrc"
alias p1="vi ~/.config/polybar/poly1"
alias p2="vi ~/.config/polybar/poly2"
alias p3="vi ~/.config/polybar/poly3"

alias ll='lsd -lh --group-dirs=first'
alias l='lsd -l --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

alias add="git add ."
alias push="git push origin main"
alias pull="git pull origin"
alias remote="git remote add origin"

#===========================function's=================
#Delete files permanently
function rmf(){
    scrub -p dod $1; shred -zun 10 -v $1
}
#Open neovim
function vi(){
    nvim $1
}
#Adjust the brightness of my screen, due to the driver XD and TLP because for the energy management of my laptop
function light(){
    sudo chmod 777 /sys/class/backlight/amdgpu_bl0/brightness | sudo tlp start
}
#git functions
function clon(){
    git clone $1
}
function commit(){
    git commit -m $1
}
fucnion gitbspwm(){
    git add .
    git commit -m "BSPwm"
    git push origin main
}

#============================plugins========================
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#hot keys
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
#bindkey $key[up] up-line-or-history
#bindkey $key[down] down-line-or-history
