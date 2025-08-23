#!/bin/bash

THRESHOLD=20

while true; do
    BATTERY=$(cat /sys/class/power_supply/BAT1/capacity | head -n 1)
    # Estado de la batería (Cargando/Descargando)
    STATUS=$(cat /sys/class/power_supply/BAT1/status | head -n 1)

    if [ "$BATTERY" -le "$THRESHOLD" ] && [ "$STATUS" != "Charging" ]; then
        notify-send -u critical "⚠️ Low Battery" "¡Solo queda $BATTERY%! Only Connect the charger." -t 10000
        sleep 300
    else
        sleep 60
    fi
done
