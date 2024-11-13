#!/usr/bin/env bash
DIR="$HOME/.config/polybar/poly3"
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar's
polybar -q app -c "$DIR"/config.ini &

polybar -q workspaces -c "$DIR"/config.ini &

polybar -q center -c "$DIR"/config.ini &

polybar -q cosmic -c "$DIR"/config.ini &

polybar -q power -c "$DIR"/config.ini &