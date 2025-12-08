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

#functions
luz(){
	sudo tlp start
}

#powerline promt
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ];
	 then
		source /usr/share/powerline/bindings/bash/powerline.sh
fi

#depending on the distro the path may vary
#exmple: -> /usr/share/powerline/bash/powerline.sh
#
