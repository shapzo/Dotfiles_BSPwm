#!/bin/bash
#rofi_command="rofi -theme $HOME/.config/rofi/themes/dracula.rasi"
rofi_command="rofi -theme $HOME/.config/rofi/themes/power.rasi"

uptime="   Seleccione una opción  "

# Options
shutdown="  Apagar"
reboot="  Reiniciar"
lock="  Bloquear"
suspend="  Suspender"
logout="  Salir"

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown\n$suspend"

chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu)"
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

