#!/bin/bash

# Target module for polybar
# Reads target info from /tmp/target

TARGET_FILE="/tmp/target"

if [ -f "$TARGET_FILE" ]; then
    ip=$(cat "$TARGET_FILE" | head -n 1)
    name=$(cat "$TARGET_FILE" | sed -n '2p')

    if [ -n "$name" ]; then
        echo "$ip - $name"
    else
        echo "$ip"
    fi
else
    echo "No target"
fi
