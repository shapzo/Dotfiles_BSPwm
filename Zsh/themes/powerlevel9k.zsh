#theme by powerlevel9k

#https://github.com/Powerlevel9k/powerlevel9k

#promt powerlevel9k
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
#source /path

custom powerlevel 9k
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=" "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(custom_linux_icon dir vcs)

POWERLEVEL9K_CUSTOM_LINUX_ICON="echo "
POWERLEVEL9K_CUSTOM_LINUX_ICON_BACKGROUND=069
POWERLEVEL9K_CUSTOM_LINUX_ICON_FOREGROUND=015
