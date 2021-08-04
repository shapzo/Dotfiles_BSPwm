#!/bin/bash
#rofi_command="rofi -theme /usr/share/rofi/themes/dracula.rasi"
rofi_command="rofi -theme $HOME/.config/rofi/themes/dracula.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="Apagar"
reboot="Reiniciar"
lock="Bloquear"
suspend="Suspender"
logout="Salir"

# Variable passed to rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        betterlockscreen -l dimblur
        ;;
    $suspend)
        mpc -q pause
        amixer set Master mute
        systemctl suspend
        ;;
    $logout)
        bspc quit
        ;;
esac

