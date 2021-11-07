#!/usr/bin/env bash
DIR="$HOME/.config/polybar/"
# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar's

polybar -q app -c "$DIR"/config.ini &
polybar -q ewmh -c "$DIR"/config.ini &
polybar -q center -c "$DIR"/config.ini &
polybar -q xbacklight -c "$DIR"/config.ini &
polybar -q volume -c "$DIR"/config.ini &
polybar -q wireless -c "$DIR"/config.ini &
polybar -q battery -c "$DIR"/config.ini &
polybar -q date -c "$DIR"/config.ini &
polybar -q power -c "$DIR"/config.ini &