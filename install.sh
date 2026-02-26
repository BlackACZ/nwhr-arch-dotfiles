#!/bin/bash

# ============================================
# We all come from NWHR
# Main installer for BSPWM NWHR environment
# Execute with: sudo ./install.sh
# ============================================

SCRIPTS_DIR="$(dirname "$0")/scripts"
DOTFILES_DIR="$(dirname "$0")"

source "$SCRIPTS_DIR/utils.sh"
check_root

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES_DIR


echo ""
echo -e "${cyan}========================================${nc}"
echo -e "${cyan}     NWHR BSPWM Environment Installer   ${nc}"
echo -e "${cyan}========================================${nc}"
echo ""

# -- Installation -- #
bash "$SCRIPTS_DIR/fix-system.sh"
bash "$SCRIPTS_DIR/aur.sh"
bash "$SCRIPTS_DIR/xorg.sh"
bash "$SCRIPTS_DIR/wm.sh"
bash "$SCRIPTS_DIR/bar.sh"
bash "$SCRIPTS_DIR/terminal.sh"
bash "$SCRIPTS_DIR/apps.sh"
bash "$SCRIPTS_DIR/fonts.sh"
bash "$SCRIPTS_DIR/dm.sh"

# -- Deploy configs -- #
echo -e "${cyan}==> deploying dotfiles...${nc}"

USER_HOME=$(eval echo ~$SUDO_USER)

# Create directories
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/bspwm"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/sxhkd"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/polybar/scripts"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/picom"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/alacritty"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/rofi"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/bin"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/wallpapers"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/Pictures"

# Copy configs
cp -r "$DOTFILES_DIR/.config/bspwm/"*       "$USER_HOME/.config/bspwm/"
cp -r "$DOTFILES_DIR/.config/sxhkd/"*       "$USER_HOME/.config/sxhkd/"
cp -r "$DOTFILES_DIR/.config/polybar/"*      "$USER_HOME/.config/polybar/"
cp -r "$DOTFILES_DIR/.config/picom/"*        "$USER_HOME/.config/picom/"
cp -r "$DOTFILES_DIR/.config/alacritty/"*    "$USER_HOME/.config/alacritty/"
cp -r "$DOTFILES_DIR/.config/rofi/"*         "$USER_HOME/.config/rofi/"
cp    "$DOTFILES_DIR/.zshrc"                 "$USER_HOME/.zshrc"
cp    "$DOTFILES_DIR/.xinitrc"               "$USER_HOME/.xinitrc"
cp    "$DOTFILES_DIR/bin/set-target"         "$USER_HOME/bin/set-target"
cp    "$DOTFILES_DIR/bin/clear-target"       "$USER_HOME/bin/clear-target"

# Permissions
chmod +x "$USER_HOME/.config/bspwm/bspwmrc"
chmod +x "$USER_HOME/.config/polybar/launch.sh"
chmod +x "$USER_HOME/.config/polybar/scripts/"*
chmod +x "$USER_HOME/bin/"*

# Fix ownership
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.zshrc"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.xinitrc"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/bin"

echo ""
echo -e "${green}========================================${nc}"
echo -e "${green}  we're done with this shit...          ${nc}"
echo -e "${green}========================================${nc}"
echo ""
echo -e "${yellow}now:${nc}"
echo -e "${yellow}  1. add a wallpaper to ~/wallpapers/wallpaper.jpg${nc}"
echo -e "${yellow}  2. reboot${nc}"
echo -e "${yellow}  3. ly will start, login${nc}"
echo -e "${yellow}  4. enjoy your rice${nc}"
echo ""
echo -e "${cyan}target usage:${nc}"
echo -e "${cyan}  set-target 10.10.10.5${nc}"
echo -e "${cyan}  set-target 10.10.10.5 machine-name${nc}"
echo -e "${cyan}  set-target 10.10.10.5 machine-name flag{here}${nc}"
echo -e "${cyan}  clear-target${nc}"
echo -e "${cyan}  targets                  # show all saved${nc}"
