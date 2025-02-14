#!/usr/bin/env sh

# Requires Packages "grim, hyprlock, magick, playerctl"

# Take A Screenshot
grim $HOME/Pictures/Hyprlock/Hyprlock.png

# Blue Screenshots
magick $HOME/Pictures/Hyprlock/Hyprlock.png -blur 0x5 $HOME/Pictures/Hyprlock/Hyprlock.png

# Pause Music
playerctl pause

# Lock Screen
pidof hyrlock || hyprlock
