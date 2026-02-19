#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_dm() {
    local packages=(
        ly
    )
    install_packages "display manager" "${packages[@]}"

    echo -e "${cyan}==> enabling ly...${nc}"
    systemctl enable ly.service
    systemctl disable getty@tty2.service 2>/dev/null

    echo -e "${green}==> display manager done${nc}"
}

check_root
install_dm
