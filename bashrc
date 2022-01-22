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

#alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

#aliases
alias cls='clear'
alias csl='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias vi='nvim'

#lsd 
alias ll='lsd -lh --group-dirs=first'
alias l='lsd -l --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

#functions
luz(){
	sudo tlp start
}

#powerline promt
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ];
	 then
		source /usr/share/powerline/bindings/bash/powerline.sh
fi