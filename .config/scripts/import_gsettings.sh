#!/bin/sh

### Manually Apply GTK 3.0 Appearances. Pulls Settings From '.config/gtk-3.0/settings.ini'

config="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/settings.ini"
if [ ! -f "$config" ]; then exit 1; fi

gnome_schema="org.gnome.desktop.interface"
gtk_theme="$(grep 'gtk-theme-name' "$config" | sed 's/.*\s*=\s*//')"
icon_theme="$(grep 'gtk-icon-theme-name' "$config" | sed 's/.*\s*=\s*//')"
cursor_theme="$(grep 'gtk-cursor-theme-name' "$config" | sed 's/.*\s*=\s*//')"
font_name="$(grep 'gtk-font-name' "$config" | sed 's/.*\s*=\s*//')"

echo "Setting GTK-Theme - $gtk_theme"
gsettings set "$gnome_schema" gtk-theme "$gtk_theme"

echo "Setting GTK-Icon-Theme - $icon_theme"
gsettings set "$gnome_schema" icon-theme "$icon_theme"

echo "Setting GTK-Cursor Theme - $cursor_theme"
gsettings set "$gnome_schema" cursor-theme "$cursor_theme"

echo "Setting GTK Font - $font_name"
gsettings set "$gnome_schema" font-name "$font_name"
