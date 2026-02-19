#!/bin/bash

source "$(dirname "$0")/utils.sh"

install_bar() {
    local packages=(
        polybar
    )
    install_packages "status bar" "${packages[@]}"
}

check_root
install_bar
