#!/bin/sh

### Launches Kitty - BTOP In A Special Hyprland Workspace

### Requires Packages "hyprland, kitty, btop"

source $HOME/.config/scripts/setup.sh 

if ! pgrep -f "spotify"; then
  hyprctl dispatch exec "[workspace special:music silent] spotify-launcher"
fi

if ! pgrep -f "cava"; then
  hyprctl dispatch exec "[workspace special:music silent] $MY_TERMINAL --title "cava" -e cava"
fi

hyprctl dispatch resizewindowpixel exact 90% 74%, class:spotify
hyprctl dispatch resizewindowpixel exact 90% 200, title:cava

hyprctl dispatch movewindowpixel exact 5% 275, class:spotify
hyprctl dispatch movewindowpixel exact 5% $STARTPOSY, title:cava

hyprctl dispatch togglespecialworkspace music
