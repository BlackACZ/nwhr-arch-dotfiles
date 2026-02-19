#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_dm() {
    local packages=(
        ly
    )
    install_packages "display manager" "${packages[@]}"

    echo -e "${cyan}==> configuring ly...${nc}"

    # Backup original config
    [ -f /etc/ly/config.ini ] && cp /etc/ly/config.ini /etc/ly/config.ini.bak

    # Copy our config
    cp "$DOTFILES_DIR/.config/ly/config.ini" /etc/ly/config.ini

    systemctl enable ly.service
    systemctl disable getty@tty2.service 2>/dev/null

    echo -e "${green}==> display manager done${nc}"
}

check_root
install_dm
