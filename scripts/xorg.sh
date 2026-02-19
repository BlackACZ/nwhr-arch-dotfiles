#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_xorg() {
    local packages=(
        xorg-server
        xorg-xinit
        xorg-xrandr
        xorg-xsetroot
        xorg-xset
        xorg-xinput
        xorg-xprop
        xorg-xdpyinfo
        xdotool
    )
    install_packages "xorg" "${packages[@]}"
}

check_root
install_xorg
