#!/bin/sh

# ============================================
# NWHR .xinitrc
# ============================================

# Merge Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Start bspwm
exec bspwm
