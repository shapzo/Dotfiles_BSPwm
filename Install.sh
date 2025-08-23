#!/usr/bin/env bash

# Install script for my BSPwm configuration

#Dirs
DIR=`pwd`
FDIR="$HOME/.local/share/fonts"
BDIR="$HOME/.config/bspwm"
SDIR="$HOME/.config/sxhkd"
RDIR="$HOME/.config/rofi"
RTDIR="$HOME/.config/rofi/themes"
PDIR="$HOME/.config/picom"
PPDIR="$HOME/.config/polybar"
LDIR="$HOME/.config/lf"

DDIR="$HOME/.config/dunst"
DDIR1="$HOME/.config/dunst/Scripts/baterry_alert.sh"
DDIR2="$HOME/.config/dunst/Scripts/songArtLogger.sh"

PP1DIR="$HOME/.config/polybar/poly1"
PP2DIR="$HOME/.config/polybar/poly2"
PP3DIR="$HOME/.config/polybar/poly3"
PPSDIR="$HOME/.config/polybar/Scripts"

KDIR="$HOME/.config/kitty"
NEODIR="$HOME/.config/neofetch"
NANZDIR="$HOME"

# Install Fonts
install_fonts() {
	echo -e "\n [*] Installing fonts..."
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

    if [[ -d "$BDIR" ]]; then
        cp $DIR/Wallpapers/img_1.jpg "$BDIR"
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

# Install dunst
install_dunst(){
    echo -e "\n [*] Installing dunst..."
    if [[ -d "$DDIR" ]]; then
        cp -rf $DIR/Dunts/* "$DDIR" && chmod +x "DDIR1" "DDIR2"
    else
        mkdir -p "$DDIR"
        cp -rf $DIR/Dunts/* "$DDIR" && chmod +x "DDIR1" "DDIR2"
    fi
}

# Install rofi-themes
install_rofi() {
	echo -e "\n [*] Installing rofi-themes..."
	if [[ -d "$RTDIR" ]]; then
		cp -rf $DIR/Rofi-themes/* "$RTDIR"
	else
		mkdir -p "$RDIR" && mkdir -p "$RTDIR"
		cp -rf $DIR/Rofi-themes/* "$RTDIR"
	fi
}

# Install lf
install_lf() {
    echo -e "\n [*] Installing Lf..."
	if [[ -d "$LDIR" ]]; then
		cp -rf $DIR/Lf/* "$LDIR"
	else
		mkdir -p "$LDIR"
		cp -rf $DIR/Lf/* "$LDIR"
	fi
}

# Installing polybar
install_polybar() {
	echo -e "\n [*] Installing polybar..."
	if [[ -d "$PPDIR" ]]; then
		cp -rf $DIR/Polybar/* "$PPDIR" && chmod +x "$PP1DIR"/launch.sh "$PP2DIR"/launch.sh "$PP3DIR"/launch.sh "$PPSDIR"/powermenu.sh
	else
		mkdir -p "$PPDIR"
		cp -rf $DIR/Polybar/* "$PPDIR" && chmod +x "$PP1DIR"/launch.sh "$PP2DIR"/launch.sh "$PP3DIR"/launch.sh "$PPSDIR"/powermenu.sh
	fi
}

#==============additional configuration files==========

#install kitty conf
install_kitty() {
	echo -e "\n [*] Installing kitty.conf..."
	if [[ -d "$KDIR" ]]; then
		cp -rf $DIR/Kitty/* "$KDIR"
	else
		mkdir -p "$KDIR"
		cp -rf $DIR/Kitty/* "$KDIR"
	fi
}

#install neofetch conf
install_neofetch() {
	echo -e "\n [*] Installing neofetch..."
	if [[ -d "$NEODIR" ]]; then
		cp $DIR/Neofetch/config.conf "$NEODIR"
	else
		mkdir -p "$NEODIR"
		cp $DIR/Neofetch/config.conf "$NEODIR"
	fi
}

#install nanorc
install_nano() {
	echo -e "\n [*] Installing nanorc..."
	if [[ -d "$NANZDIR" ]]; then
        cp $DIR/nanorc "$NANZDIR" && mv "$NANZDIR"/nanorc "$NANZDIR"/.nanorc
	else
		echo -e "error"
	fi
}

#install zshrc
install_zsh() {
	echo -e "\n [*] Installing zshrc..."
	if [[ -d "$NANZDIR" ]]; then
		cp $DIR/zshrc "$NANZDIR" && mv "$NANZDIR"/zshrc "$NANZDIR"/.zshrc
	else
		echo -e "error"
	fi
}

#main
main() {
    clear

        echo -e "\n"
        echo -e " ██████╗ ███████╗██████╗ ██╗    ██╗███╗   ███╗    ███████╗███████╗████████╗██╗   ██╗██████╗  "
        echo -e " ██╔══██╗██╔════╝██╔══██╗██║    ██║████╗ ████║    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗ "
        echo -e " ██████╔╝███████╗██████╔╝██║ █╗ ██║██╔████╔██║    ███████╗█████╗     ██║   ██║   ██║██████╔╝ "
        echo -e " ██╔══██╗╚════██║██╔═══╝ ██║███╗██║██║╚██╔╝██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝  "
        echo -e " ██████╔╝███████║██║     ╚███╔███╔╝██║ ╚═╝ ██║    ███████║███████╗   ██║   ╚██████╔╝██║      "
        echo -e " ╚═════╝ ╚══════╝╚═╝      ╚══╝╚══╝ ╚═╝     ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝      "

        install_fonts
        install_bspwm
        install_sxhkd
        install_picom
        install_dunst
        install_rofi
        install_polybar
        install_lf

        echo -e "\n"

        echo -e "Additional configuration, which contains: neofetch, kitty config, zshrc and nanorc"

        echo -e "chosse an option - "
        echo -e "
                [1] yes
                [2] no "
        
        read -p "[?] select an option: "

        if [[ $REPLY == "1" ]]; then

            install_neofetch
            install_kitty
            install_nano
            install_zsh

            echo -e "\n"

        elif [[ $REPLY == "2" ]]; then
            
            exit 1

        else

            echo -e "\n [!] invalid option, Exiting....\n"
        
        fi

}

main