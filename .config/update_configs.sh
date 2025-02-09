#!/bin/bash

GITHUB_CONFIG_DIR="$HOME/Git/Configs/.config/"
LOCAL_CONFIG_DIR="$HOME/.config"

set -e

# Iterate Over All Files In The GitHub Config Directory
find "$GITHUB_CONFIG_DIR" -type f ! -path "$GITHUB_CONFIG_DIR/.git/*" | while read -r file; do 
  # Get The Relative Path Of The File
  relative_path="${file#$GITHUB_CONFIG_DIR/}"
  
  # Create The Destination Directory In "~/.config" If It Doesn't Exist
  mkdir -p "$LOCAL_CONFIG_DIR/$(dirname "$relative_path")"
  
  # Delete The Existing Config File If It Exists
  if [ -e "$LOCAL_CONFIG_DIR/$relative_path" ]; then
    rm -f "$LOCAL_CONFIG_DIR/$relative_path"
  fi

  # Create The Symbolic Link, Overwriting It If It Exists
  ln -sf "$file" "$LOCAL_CONFIG_DIR/$relative_path"
done

echo "All Files Have Been Sym-Linked From $GITHUB_CONFIG_DIR to $LOCAL_CONFIG_DIR!"
