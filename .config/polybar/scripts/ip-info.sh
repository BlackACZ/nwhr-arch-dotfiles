#!/bin/bash

# IP info module for polybar
# Left click: toggle WAN/LAN
# Right click: copy to clipboard

STATE_FILE="/tmp/ip-info-state"

get_lan() {
    ip -4 addr show scope global | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -n 1
}

get_wan() {
    curl -s --max-time 3 ifconfig.me 2>/dev/null || echo "N/A"
}

# Default state is LAN
if [ ! -f "$STATE_FILE" ]; then
    echo "lan" > "$STATE_FILE"
fi

state=$(cat "$STATE_FILE")

case "$1" in
    --toggle)
        if [ "$state" = "lan" ]; then
            echo "wan" > "$STATE_FILE"
        else
            echo "lan" > "$STATE_FILE"
        fi
        ;;
    --copy)
        if [ "$state" = "lan" ]; then
            get_lan | xclip -selection clipboard
            dunstify "LAN IP copied"
        else
            get_wan | xclip -selection clipboard
            dunstify "WAN IP copied"
        fi
        ;;
    *)
        if [ "$state" = "lan" ]; then
            ip=$(get_lan)
            echo "LAN: ${ip:-N/A}"
        else
            ip=$(get_wan)
            echo "WAN: ${ip:-N/A}"
        fi
        ;;
esac
