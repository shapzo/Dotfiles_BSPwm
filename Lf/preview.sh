#!/bin/sh
case "$1" in
    *.pdf) pdftotext "$1" - ;;
    *.jpg|*.png|*.gif) ueberzugpp "$1" ;;
    *.md) glow -s dark "$1" ;;
    *) highlight -O ansi --force "$1" ;;
esac