#!/bin/sh

### Restart Waybar When Changes To It's Config Files Are Made

CONFIG_FILES="$HOME/.config/waybar/config $HOME/.config/waybar/style.css"

trap "killall waybar" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall waybar
done
