#!/bin/bash

SINK=$(pactl get-default-sink)
PORT=$(pactl list sinks | awk "/$SINK/{f=1} f && /Active Port/{print \$3; exit}")

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n1 | tr -d '%')
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

if [[ "$MUTED" == "yes" ]]; then
  ICON=""
  echo "%{F#db0303}$ICON%{F-}"
  exit 0
elif [[ "$PORT" == *"headphones"* ]]; then
  ICON=""
elif (( VOLUME < 30 )); then
  ICON=""
elif (( VOLUME < 70 )); then
  ICON=""
else
  ICON=""
fi

echo "$ICON"
