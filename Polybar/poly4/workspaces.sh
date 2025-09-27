#!/bin/bash

bspc subscribe desktop_focus node_add node_remove | while read -r _; do
  # Obtiene todos los desktops activos (con ventanas o el actual)
  desktops=$(bspc query -D --names --desktop focused --desktop .occupied)

  output=""
  for d in $desktops; do
    if [ "$d" = "$(bspc query -D -d focused --names)" ]; then
      output+="%{F#ffffff}  $d %{F-} "   # resalta el actual en color blanco
    else
      output+="$d "
    fi
  done

  echo "$output"
done
