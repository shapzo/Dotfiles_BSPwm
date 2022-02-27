#!/usr/bin/env bash

# Install script for my BSPwm configuration
# --BETA--

#Dirs
DIR='pwd'
FDIR="$HOME/.local/share/fonts"
BDIR="$HOME/.config/bspwm"
SDIR="$HOME/.config/sxhkd"
RDIR="$HOME/.config/rofi"
RTDIR="$HOME/.config/rofi/themes"
PDIR="$HOME/.config/picom"
PPDIR="$HOME/.config/polybar"

PP1DIR="$HOME/.config/polybar/poly1"
PP2DIR="$HOME/.config/polybar/poly2"
PP3DIR="$HOME/.config/polybar/poly3"

# Install Fonts
install_fonts() {
	echo -e "\n[*] Installing fonts..."
	if [[ -d "$FDIR" ]]; then
		cp -rf $DIR/Fonts/* "$FDIR"
	else
		mkdir -p "$FDIR"
		cp -rf $DIR/Fonts/* "$FDIR"
	fi
}

# Install BSPwmrc
install_bspwm(){
    echo -e "\n [*] Installing bspwmrc..."
    if [[ -d "$BDIR" ]]; then
        cp $DIR/bspwmrc "$BDIR" && cd "$BDIR" && chmod +x bspwmrc
    else
        mkdir -p "$BDIR"
        cp $DIR/bspwmrc "$BDIR" && cd "$BDIR" && chmod +x bspwmrc
    fi
}

# Install sxhkdrc
install_sxhkd(){
    echo -e "\n [*] Installing sxhkdrc..."
    if [[ -d "$SDIR" ]]; then
        cp $DIR/sxhkdrc "$SDIR" && cd "$SDIR" && chmod +x sxhkdrc
    else
        mkdir -p "$SDIR"
        cp $DIR/sxhkdrc "$SDIR" && cd "$SDIR" && chmod +x sxhkdrc
    fi
}

# Install picom
install_picom(){
    echo -e "\n [*] Installing picom..."
    if [[ -d "$PDIR" ]]; then
        cp $DIR/picom.conf "$PDIR"
    else
        mkdir -p "$PDIR"
        cp $DIR/picom.conf "$PDIR"
    fi
}

#install rofi-themes
install_rofi() {
	echo -e "\n[*] Installing rofi-themes..."
	if [[ -d "$RTDIR" ]]; then
		cp -rf $DIR/Rofi-themes/* "$RTDIR"
	else
		mkdir -p "$RDIR" && mkdir -p "$RFDIR"
		cp -rf $DIR/Rofi-themes/* "$RFDIR"
	fi
}

#installing polybar
install_polybar() {
	echo -e "\n[*] Installing polybar..."
	if [[ -d "$PPDIR" ]]; then
		cp -rf $DIR/Polybar/* "$PPDIR" && chmod +x "$PP1DIR"/launch.sh "$PP1DIR"/scripts/powermenu.sh "$PP2DIR"/launch.sh "$PP2DIR"/scripts/powermenu.sh "$PP3DIR"/launch.sh "$PP3DIR"/scripts/powermenu.sh
	else
		mkdir -p "$PPDIR"
		cp -rf $DIR/Polybar/* "$PPDIR" && chmod +x "$PP1DIR"/launch.sh "$PP1DIR"/scripts/powermenu.sh "$PP2DIR"/launch.sh "$PP2DIR"/scripts/powermenu.sh "$PP3DIR"/launch.sh "$PP3DIR"/scripts/powermenu.sh
	fi
}