#!/bin/bash

LOW_THRESHOLD=35
HIGH_THRESHOLD=90
BATTERY_PATH="/sys/class/power_supply/BAT1"

notified_low=false
notified_full=false

while true; do
    BATTERY=$(<"$BATTERY_PATH/capacity")
    STATUS=$(<"$BATTERY_PATH/status")

    # CASE 1: Low battery and discharging
    if (( BATTERY <= LOW_THRESHOLD )) && [[ "$STATUS" == "Discharging" ]]; then
        if [[ "$notified_low" == false ]]; then
            notify-send -u critical \
                -i battery-caution \
                "⚠️ Low Battery" \
                "Only ${BATTERY}% remaining. Please plug in the charger." \
                -t 0
            notified_low=true
        fi
        notified_full=false
        sleep 120

    # CASE 2: High battery and charging
    elif (( BATTERY >= HIGH_THRESHOLD )) && [[ "$STATUS" != "Discharging" ]]; then
        if [[ "$notified_full" == false ]]; then
            notify-send -u normal \
                -i battery-full-charging \
                "🔋 Battery Full" \
                "Reached ${BATTERY}%. You can now unplug the charger." \
                -t 0
            notified_full=true
        fi
        notified_low=false
        sleep 60

    # CASE 3: Normal state
    else
        (( BATTERY > LOW_THRESHOLD )) && notified_low=false
        (( BATTERY < HIGH_THRESHOLD )) && notified_full=false
        sleep 60
    fi
done