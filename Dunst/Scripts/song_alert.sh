#!/bin/bash

CACHE_DIR="$HOME/.cache/dunst/spotify"
COVER="$CACHE_DIR/cover.png"

mkdir -p "$CACHE_DIR"

if ! playerctl -p spotify status &>/dev/null; then
    exit 0
fi

TITLE=$(playerctl -p spotify metadata title)
ARTIST=$(playerctl -p spotify metadata artist)
ALBUM=$(playerctl -p spotify metadata album)

ART_URL=$(playerctl -p spotify metadata mpris:artUrl | sed 's/open.spotify.com/i.scdn.co/')

if [[ -n "$ART_URL" ]]; then
    curl -sL "$ART_URL" -o "$COVER"
fi

notify-send -a "Spotify" -i "$COVER" "$TITLE" "$ARTIST — $ALBUM"
