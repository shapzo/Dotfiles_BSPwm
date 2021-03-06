#!/usr/bin/env bash
DIR="$HOME/.config/polybar/poly2"
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar's
polybar -q master -c "$DIR"/config.ini &