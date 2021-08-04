#!/usr/bin/env bash
DIR="$HOME/.config/polybar/BSPwm"
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar's
#polybar -q example -c "$DIR"/config &

polybar left -c ~/.config/polybar/BSPwm/config.ini &

polybar center -c ~/.config/polybar/BSPwm/config.ini &

polybar volume -c ~/.config/polybar/BSPwm/config.ini &

polybar battery -c ~/.config/polybar/BSPwm/config.ini &

polybar wireless -c ~/.config/polybar/BSPwm/config.ini &

polybar date -c ~/.config/polybar/BSPwm/config.ini &

polybar power -c ~/.config/polybar/BSPwm/config.ini &