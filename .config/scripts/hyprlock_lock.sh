#!/usr/bin/env sh

PRIMONITOR=eDP-1

### Locks The Screem & Displays A Blurred Desktop Background

### Requires Packages "grim, hyprlock, magick, playerctl"

### Take A Screenshot, Change Default
grim -o $PRIMONITOR $HOME/Pictures/Hyprlock/Hyprlock.png

### Blur Screenshots
magick $HOME/Pictures/Hyprlock/Hyprlock.png -blur 0x5 $HOME/Pictures/Hyprlock/Hyprlock.png

### Pause Music If Playing
playerctl pause

### Lock Screen
pidof hyprlock || hyprlock
