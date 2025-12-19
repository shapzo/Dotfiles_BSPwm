#!/usr/bin/env bash

ETH="enp2s0"
WIFI="wlp3s0"

# Ethernet conectado?
if ip link show "$ETH" 2>/dev/null | grep -q "state UP"; then
  echo "%{F#89b4fa}  Ethernet%{F-}"
  exit 0
fi

# WiFi conectado?
if ip link show "$WIFI" 2>/dev/null | grep -q "state UP"; then
  ESSID=$(iw dev "$WIFI" link | awk -F': ' '/SSID/ {print $2}')
  SIGNAL=$(grep "$WIFI" /proc/net/wireless | awk '{print int($3)}')

  if [[ $SIGNAL -gt 70 ]]; then ICON=" 󰤨"
  elif [[ $SIGNAL -gt 55 ]]; then ICON=" 󰤥"
  elif [[ $SIGNAL -gt 40 ]]; then ICON=" 󰤢"
  elif [[ $SIGNAL -gt 25 ]]; then ICON=" 󰤟"
  else ICON="󰤯"
  fi

  echo "%{F#89b4fa}$ICON  $ESSID%{F-}"
  exit 0
fi

# Nada conectado
echo "%{F#ed245c}󰤮  Sin red%{F-}"
