#!/bin/bash

# Instead of using DOTFILES_DIR, we compute the repo root
REPO_ROOT=$(git rev-parse --show-toplevel)

# Check for availability of ly.service or lyd.service
if systemctl list-unit-files | grep -q 'ly.service'; then
    sudo systemctl enable ly.service
elif systemctl list-unit-files | grep -q 'lyd.service'; then
    sudo systemctl enable lyd.service
else
    echo "No ly or lyd service found"
fi
