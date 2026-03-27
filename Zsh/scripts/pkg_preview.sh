#!/usr/bin/env bash
pkg="$1"

# 1. Status
if pacman -Qi "$pkg" &>/dev/null; then
    echo "Status             : ✔️ INSTALLED"
else
    echo "Status             : ❌ NOT INSTALLED"
fi
echo "---"

# 2. Info with expac
expac -H M -S "📦  Name           : %n
📂  Repository     : %r
🔖  Version        : %v
🏗️  Architecture   : %a
📝  Description    : %d
🌐  URL            : %u
⚖️  Licenses       : %L
💾  Installed Size : %m
📅  Build Date     : %b
🔗  Depends on     : %D
➕  Optional Deps  : %O
⚠️  Conflicts      : %C" "$pkg" 2>/dev/null || echo "⚠️ Package not found: $pkg"

# 3. Files
echo "---"
echo "📂 Files :"
if pacman -Qi "$pkg" &>/dev/null; then
    pacman -Ql "$pkg" | cut -d" " -f2- | head -15 | sed "s/^/  - /"
else
    pacman -Fl "$pkg" 2>/dev/null | awk '{print $2}' | head -15 | sed "s/^/  - /" || echo "  - (🚫 Not available)"
fi