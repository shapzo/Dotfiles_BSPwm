# java jdbc
export CLASSPATH=$CLASSPATH:/usr/share/java/mariadb-jdbc.jar:/usr/share/java/jaybird-jdbc.jar

#pywal theme
#[[ -f ~/.cache/wal/colors.sh ]] && source ~/.cache/wal/colors.sh

# Make FZF use fd by default (respects .gitignore and is faster)
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"