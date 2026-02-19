#!/bin/bash

# We all come from NWHR
# Shared colors and functions

red='\e[0;31m'
green='\e[0;32m'
cyan='\e[0;36m'
yellow='\e[0;33m'
nc='\e[0m'

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo -e "${red}you need root${nc}"
        exit 1
    fi
}

install_packages() {
    local name=$1
    shift
    local packages=("$@")

    echo -e "${cyan}==> installing ${name}...${nc}"
    pacman -S --noconfirm --needed "${packages[@]}"

    if [ $? -eq 0 ]; then
        echo -e "${green}==> ${name} done${nc}"
    else
        echo -e "${red}==> ${name} failed${nc}"
        return 1
    fi
}

install_aur_packages() {
    local name=$1
    shift
    local packages=("$@")

    echo -e "${cyan}==> installing ${name} (AUR)...${nc}"
    sudo -u "$SUDO_USER" paru -S --noconfirm --needed "${packages[@]}"

    if [ $? -eq 0 ]; then
        echo -e "${green}==> ${name} done${nc}"
    else
        echo -e "${red}==> ${name} failed${nc}"
        return 1
    fi
}
