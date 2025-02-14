#!/bin/sh

if ! pgrep -f "kitty --title kittyquake"; then
  hyprctl dispatch exec "[workspace special:kittyquake silent] kitty --title "kittyquake""

fi

hyprctl dispatch togglespecialworkspace kittyquake