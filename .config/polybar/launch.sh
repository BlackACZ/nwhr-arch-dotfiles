#!/bin/bash

# Kill existing polybar instances
killall -q polybar

# Wait for processes to shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch
polybar main -c $HOME/.config/polybar/config.ini &
