#!/bin/sh

### Launches Kitty With A Custom Title In A Special Hyprland Workspace
### Hyrpland Then Applies Rules To Open It Like A Quake Style Drop Down Terminal

### Requires Packages "hyprland, kitty"

if ! pgrep -f "kitty --title kittyquake"; then
  hyprctl dispatch exec "[workspace special:kittyquake silent] kitty --title "kittyquake""
fi

hyprctl dispatch togglespecialworkspace kittyquake
