#!/bin/bash

case $1 in
    up)
        pamixer -i 5 --unmute
        ;;
    down)
        pamixer -d 5 --unmute
        ;;
    mute)
        pamixer -t
        ;;
esac

VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
    notify-send -a "Volume" -u low -i audio-volume-muted-symbolic \
        -h string:x-dunst-stack-tag:volume \
        "Volumen" "Mute"
else

    if [ "$VOLUME" -lt 30 ]; then
        ICON="audio-volume-low-symbolic"
    elif [ "$VOLUME" -lt 70 ]; then
        ICON="audio-volume-medium-symbolic"
    else
        ICON="audio-volume-high-symbolic"
    fi

    
    notify-send -a "Volume" -u low -i "$ICON" \
        -h int:value:"$VOLUME" \
        -h string:x-dunst-stack-tag:volume \
        "Volumen" "${VOLUME}%"
fi