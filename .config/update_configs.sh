#!/bin/sh

MY_CONFIG_DIR="$HOME/Git/Configs/.config"
LOCAL_CONFIG_DIR="$HOME/.config"

set -e

# Iterate Over All Files In The My_Config Directory
find "$MY_CONFIG_DIR" -type f ! -path "$MY_CONFIG_DIR/.git/*" | while read -r file; do 
  # Get The Relative Path Of Each File
  relative_path="${file#$MY_CONFIG_DIR/}"
  
  # Create The Destination Directory In "~/.config" If It Doesn't Exist
  mkdir -p "$LOCAL_CONFIG_DIR/$(dirname "$relative_path")"
  
  # Delete Existing Config Files If They Exist
  if [ -e "$LOCAL_CONFIG_DIR/$relative_path" ]; then
    rm -f "$LOCAL_CONFIG_DIR/$relative_path"
  fi

  # Create Symbolic Links To Each File, Overwriting Them If They Exist
  ln -sf "$file" "$LOCAL_CONFIG_DIR/$relative_path"
done

echo "All Files Have Been Sym-Linked From $MY_CONFIG_DIR to $LOCAL_CONFIG_DIR!"

sleep 2

# Restart Hyprland When Complete
echo "Reloading Hyprland! "
hyprctl reload > /dev/null
echo "Done !"
