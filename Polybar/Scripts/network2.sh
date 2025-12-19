#!/usr/bin/env bash

ETH="enp2s0"
WIFI="wlp3s0"
STATE="/tmp/polybar-network-state"

# estado por defecto
[[ ! -f $STATE ]] && echo "icon" > "$STATE"
MODE=$(cat "$STATE")

toggle() {
  if [[ "$MODE" == "icon" ]]; then
    echo "text" > "$STATE"
  else
    echo "icon" > "$STATE"
  fi
}

# toggle con click
if [[ "$1" == "toggle" ]]; then
  toggle
  exit 0
fi

# ---------- Ethernet ----------
if ip link show "$ETH" 2>/dev/null | grep -q "state UP"; then
  if [[ "$MODE" == "icon" ]]; then
    echo "%{F#ffffff A1:$0 toggle:} %{A F-}"
  else
    echo "%{F#ffffff A1:$0 toggle:}  Ethernet%{A F-}"
  fi
  exit 0
fi

# ---------- WiFi ----------
if ip link show "$WIFI" 2>/dev/null | grep -q "state UP"; then
  ESSID=$(iw dev "$WIFI" link | awk -F': ' '/SSID/ {print $2}')
  SIGNAL=$(grep "$WIFI" /proc/net/wireless | awk '{print int($3)}')

  if [[ $SIGNAL -gt 70 ]]; then ICON=" 󰤨"
  elif [[ $SIGNAL -gt 55 ]]; then ICON=" 󰤥"
  elif [[ $SIGNAL -gt 40 ]]; then ICON=" 󰤢"
  elif [[ $SIGNAL -gt 25 ]]; then ICON=" 󰤟"
  else ICON="󰤯"
  fi

  if [[ "$MODE" == "icon" ]]; then
    echo "%{F#ffffff A1:$0 toggle:}$ICON  %{A F-}"
  else
    echo "%{F#ffffff A1:$0 toggle:}$ICON  $ESSID%{A F-}"
  fi
  exit 0
fi

# ---------- Sin red ----------
echo "%{F#ed245c A1:$0 toggle:}󰤮  Sin red%{A F-}"
