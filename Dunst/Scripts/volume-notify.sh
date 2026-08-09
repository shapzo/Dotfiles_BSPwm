#!/bin/bash

# Subir, bajar o alternar silencio (mute) según el argumento recibido
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
    # Determinar el icono según el nivel
    if [ "$VOLUME" -lt 30 ]; then
        ICON="audio-volume-low-symbolic"
    elif [ "$VOLUME" -lt 70 ]; then
        ICON="audio-volume-medium-symbolic"
    else
        ICON="audio-volume-high-symbolic"
    fi

    # -h int:value:$VOLUME activa la barra de progreso definida en tu dunstrc
    notify-send -a "Volume" -u low -i "$ICON" \
        -h int:value:"$VOLUME" \
        -h string:x-dunst-stack-tag:volume \
        "Volumen" "${VOLUME}%"
fi