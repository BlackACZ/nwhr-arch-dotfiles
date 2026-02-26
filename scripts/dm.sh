#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_dm() {
    local packages=(
        ly
    )
    install_packages "display manager" "${packages[@]}"

    echo -e "${cyan}==> configuring ly...${nc}"

    # Repo root = one level above scripts/
    local REPO_ROOT
    REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

    # Backup original config
    [ -f /etc/ly/config.ini ] && cp /etc/ly/config.ini /etc/ly/config.ini.bak

    # Copy our config if it exists
    if [ -f "$REPO_ROOT/.config/ly/config.ini" ]; then
        cp "$REPO_ROOT/.config/ly/config.ini" /etc/ly/config.ini
        echo -e "${green}==> ly config installed to /etc/ly/config.ini${nc}"
    else
        echo -e "${yellow}==> warning: $REPO_ROOT/.config/ly/config.ini not found, skipping copy${nc}"
    fi

    # Enable service robustly
    if systemctl list-unit-files | grep -qE '^ly\.service'; then
        systemctl enable ly.service
        echo -e "${green}==> enabled ly.service${nc}"
    elif systemctl list-unit-files | grep -qE '^lyd\.service'; then
        systemctl enable lyd.service
        echo -e "${green}==> enabled lyd.service${nc}"
    else
        echo -e "${yellow}==> warning: ly service unit not found (ly.service/lyd.service). Enable it manually if needed.${nc}"
        echo -e "${yellow}   try: systemctl list-unit-files | grep -i ly${nc}"
    fi

    systemctl disable getty@tty2.service 2>/dev/null

    echo -e "${green}==> display manager done${nc}"
}

check_root
install_dm
