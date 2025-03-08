#!/usr/bin/env sh

### Locks The Screem & Displays A Blurred Desktop Background

### Requires Packages "grim, hyprlock, magick, playerctl"

### Take A Screenshot
grim $HOME/Pictures/Hyprlock/Hyprlock.png

### Blur Screenshots
magick $HOME/Pictures/Hyprlock/Hyprlock.png -blur 0x5 $HOME/Pictures/Hyprlock/Hyprlock.png

### Pause Music If Playing
playerctl pause

### Lock Screen
pidof hyprlock || hyprlock
