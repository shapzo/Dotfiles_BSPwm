#!/bin/bash

case $1 in
    up)
        xbacklight -inc 5
        ;;
    down)
        xbacklight -dec 5
        ;;
esac

BRIGHTNESS=$(printf "%.0f" "$(xbacklight -get)")

notify-send -a "Brightness" -u low -i display-brightness-symbolic \
    -h int:value:"$BRIGHTNESS" \
    -h string:x-dunst-stack-tag:brightness \
    "Brillo" "${BRIGHTNESS}%"