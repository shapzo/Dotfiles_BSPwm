#!/bin/bash

case $1 in
    up)
        xbacklight -inc 5
        ;;
    down)
        xbacklight -dec 5
        ;;
esac

# Obtener el porcentaje actual de xbacklight y redondearlo a entero
BRIGHTNESS=$(printf "%.0f" "$(xbacklight -get)")

# Enviar la notificación a Dunst con la barra de progreso
notify-send -a "Brightness" -u low -i display-brightness-symbolic \
    -h int:value:"$BRIGHTNESS" \
    -h string:x-dunst-stack-tag:brightness \
    "Brillo" "${BRIGHTNESS}%"