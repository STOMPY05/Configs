#!/usr/bin/env sh

# Requires Packages "grim, hyprlock, magick"

grim $HOME/Pictures/Hyprlock/Hyprlock.png

magick $HOME/Pictures/Hyprlock/Hyprlock.png -blur 0x5 $HOME/Pictures/Hyprlock/Hyprlock.png

pidof hyrlock || hyprlock
