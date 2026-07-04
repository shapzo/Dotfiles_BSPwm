#!/usr/bin/env bash

ETH="enp2s0"
WIFI="wlp3s0"
STATE="/tmp/polybar-network-state"
INET_CACHE="/tmp/polybar-inet-status"
SCRIPT_PATH="$(realpath "$0")"

COLOR_OFF="#ed245c"
COLOR_WARN="#f39c12"

[[ ! -f "$STATE" ]] && echo "icon" > "$STATE"
MODE=$(<"$STATE")

# -------------------------------------------------
# Check internet with a 30-second cache
# -------------------------------------------------
check_internet() {
  if [[ -f "$INET_CACHE" ]] && (( $(date +%s) - $(stat -c %Y "$INET_CACHE") < 30 )); then
    return $(<"$INET_CACHE")
  fi
  if ping -c 1 -W 1 8.8.8.8 &>/dev/null; then
    echo 0 > "$INET_CACHE"; return 0
  else
    echo 1 > "$INET_CACHE"; return 1
  fi
}

# -------------------------------------------------
# Toggle between icon/text mode on click
# -------------------------------------------------
toggle() {
  if [[ "$MODE" == "icon" ]]; then
    echo "text" > "$STATE"
  else
    echo "icon" > "$STATE"
  fi
}

[[ "$1" == "toggle" ]] && { toggle; exit 0; }

# -------------------------------------------------
# Ethernet
# -------------------------------------------------
if ip link show "$ETH" 2>/dev/null | grep -q "state UP"; then
  if check_internet; then
    ICON=" "
    LABEL="Ethernet"
  else
    ICON="%{F$COLOR_WARN}󱘖 %{F-}"
    LABEL="%{F$COLOR_WARN}No Internet%{F-}"
  fi

  if [[ "$MODE" == "icon" ]]; then
    echo "%{A1:$SCRIPT_PATH toggle:}$ICON%{A}"
  else
    echo "%{A1:$SCRIPT_PATH toggle:}$ICON $LABEL%{A}"
  fi
  exit 0
fi

# -------------------------------------------------
# WiFi
# -------------------------------------------------
if ip link show "$WIFI" 2>/dev/null | grep -q "state UP"; then
  ESSID=$(iw dev "$WIFI" link | awk -F': ' '/SSID/ {print $2}')

  # Signal in dBm → percentage
  SIGNAL=$(iw dev "$WIFI" link | awk '/signal/ {print int($2)}')
  SIGNAL=$(( (SIGNAL + 90) * 100 / 60 ))
  (( SIGNAL > 100 )) && SIGNAL=100
  (( SIGNAL < 0 ))   && SIGNAL=0

  if   (( SIGNAL > 70 )); then ICON="󰤨"
  elif (( SIGNAL > 55 )); then ICON="󰤥"
  elif (( SIGNAL > 40 )); then ICON="󰤢"
  elif (( SIGNAL > 25 )); then ICON="󰤟"
  else                         ICON="󰤯"
  fi

  if ! check_internet; then
    ICON="%{F$COLOR_WARN}󰤫 %{F-}"
    ESSID="%{F$COLOR_WARN}No Internet%{F-}"
  fi

  if [[ "$MODE" == "icon" ]]; then
    echo "%{A1:$SCRIPT_PATH toggle:}$ICON%{A}"
  else
    echo "%{A1:$SCRIPT_PATH toggle:}$ICON  $ESSID%{A}"
  fi
  exit 0
fi

# -------------------------------------------------
# No network
# -------------------------------------------------
echo "%{F$COLOR_OFF}%{A1:$SCRIPT_PATH toggle:}󰤮 No network%{A}%{F-}"