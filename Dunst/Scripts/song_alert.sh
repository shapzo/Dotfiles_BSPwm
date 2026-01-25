#!/bin/bash

CACHE_DIR="$HOME/.cache/dunst/spotify"
COVER="$CACHE_DIR/cover.png"
mkdir -p "$CACHE_DIR"

send_notification() {
    TITLE=$(playerctl -p spotify metadata title)
    ARTIST=$(playerctl -p spotify metadata artist)
    ALBUM=$(playerctl -p spotify metadata album)
    ART_URL=$(playerctl -p spotify metadata mpris:artUrl)

    if [[ -n "$ART_URL" ]]; then
        curl -sL "$ART_URL" -o "$COVER"
    else
        COVER="spotify-client" 
    fi

    notify-send -a "Spotify" -u low -i "$COVER" "$TITLE" "$ARTIST\n($ALBUM)"
}

playerctl -p spotify metadata -F --format '{{title}}' | while read -r line; do
    send_notification
done