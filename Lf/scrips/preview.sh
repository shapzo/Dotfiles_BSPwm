#!/bin/sh

case "$1" in
    # Documentos
    *.pdf) pdftotext "$1" - ;;
    *.docx|*.odt) pandoc -s "$1" --to plain ;;
    
    # Imágenes (mejor compatibilidad)
    *.jpg|*.jpeg|*.png|*.gif|*.webp)
        if [ -n "$UEBERZUGPP_FIFO" ]; then
            ueberzugpp "$1"
        else
            chafa "$1"
        fi
        ;;
    
    # Videos
    *.mp4|*.mkv|*.avi|*.mov)
        mediainfo "$1" || echo "Video: $(basename "$1")"
        ;;
    
    # Audio
    *.mp3|*.flac|*.wav)
        exiftool "$1" || echo "Audio: $(basename "$1")"
        ;;
    
    # Markdown
    *.md) 
        if command -v glow >/dev/null; then
            glow -s dark "$1"
        else
            cat "$1"
        fi
        ;;
    
    # Código fuente
    *.py|*.js|*.html|*.css|*.json|*.xml|*.yaml|*.yml|*.sh|*.bash|*.zsh)
        highlight -O ansi --force "$1" || cat "$1"
        ;;
    
    # Archivos comprimidos
    *.zip|*.tar|*.gz|*.bz2|*.rar|*.7z)
        atool -l "$1" || echo "Archivo comprimido: $(basename "$1")"
        ;;
    
    # Texto plano
    *.txt|*.log|*.conf|*.config)
        cat "$1"
        ;;
    
    # Binarios (seguridad)
    *.bin|*.exe|*.deb|*.rpm)
        echo "Archivo binario: $(basename "$1")"
        file "$1"
        ;;
    
    # Default
    *) 
        if [ -d "$1" ]; then
            tree -L 1 "$1"
        else
            file "$1"
        fi
        ;;
esac