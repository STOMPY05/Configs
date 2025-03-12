#!/bin/sh

### Launches Kitty - BTOP In A Special Hyprland Workspace

### Requires Packages "hyprland, kitty, btop"

source $HOME/.config/scripts/setup.sh 

if ! pgrep -f "$MY_TERMINAL --title btop"; then
  hyprctl dispatch exec "[workspace special:kittybtop silent] $MY_TERMINAL --title "btop" -e btop"
fi



hyprctl dispatch resizewindowpixel exact 90% 90%, title:btop

hyprctl dispatch togglespecialworkspace kittybtop

hyprctl dispatch centerwindow 1