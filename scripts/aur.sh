#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_paru() {
    if command -v paru &>/dev/null; then
        echo -e "${green}==> paru already installed${nc}"
        return 0
    fi

    echo -e "${cyan}==> installing paru...${nc}"

    pacman -S --noconfirm --needed base-devel git

    local tmp_dir=$(sudo -u "$SUDO_USER" mktemp -d)
    sudo -u "$SUDO_USER" git clone https://aur.archlinux.org/paru.git "$tmp_dir/paru"
    cd "$tmp_dir/paru"
    sudo -u "$SUDO_USER" makepkg -si --noconfirm
    cd -
    rm -rf "$tmp_dir"

    echo -e "${green}==> paru done${nc}"
}

check_root
install_paru
