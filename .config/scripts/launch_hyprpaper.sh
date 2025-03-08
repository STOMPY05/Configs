#!/usr/bin/env sh

### Picks From A Random Wallpaper In WALLPAPER_DIR And Loads It Via 'hyprpaper'

### Requires Packages "grep, hyprland, hyprpaper, sed"

HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"

WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"


### Checks That The HyprPaper Config Exists
if [ -f "$HYPRPAPER_CONFIG" ]; then
    CURRENT_WALLPAPER=$(grep '^\$WALLPAPER' ~/.config/hypr/hyprpaper.conf | cut -d'=' -f2 | tr -d ' "')
else
    echo "File $HYPRPAPER_CONFIG Does Not Exist!"
    exit 1
fi

### Get A Random Wallpaper That Is Not The Current One
NEW_WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALLPAPER")" | shuf -n 1)

### Modify The HyprPaper Config File With The New Wallpaper
sed --follow-symlinks -i "s|^\s*\$WALLPAPER=\s*.*|\$WALLPAPER=$NEW_WALLPAPER|" "$HYPRPAPER_CONFIG"

hyprpaper
