#!/bin/sh

### Launches Kitty With A Custom Title In A Special Hyprland Workspace
### Hyrpland Then Applies Rules To Open It Like A Quake Style Drop Down Terminal

### Requires Packages "hyprland, kitty"

if ! pgrep -f "kitty --title kittyquake"; then
  hyprctl dispatch exec "[workspace special:kittyquake silent] kitty --title "kittyquake""
fi

hyprctl dispatch resizewindowpixel exact 70% 40%, title:kittyquake

### $STARTPOSY Is Set In Hyprland Variables (It's The Start Y Position On Screen Below The Top Bar)
hyprctl dispatch movewindowpixel exact 15% $STARTPOSY, title:kittyquake

hyprctl dispatch togglespecialworkspace kittyquake
