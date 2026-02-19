#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_fonts() {
    local packages=(
        ttf-jetbrains-mono-nerd
        ttf-font-awesome
        noto-fonts
        noto-fonts-emoji
    )
    install_packages "fonts" "${packages[@]}"
}

check_root
install_fonts
