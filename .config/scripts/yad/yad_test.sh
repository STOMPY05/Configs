yad --title="Tree Menu" --tree --width=400 --height=300 --center \
    --column="Options" --column="Command" --hide-column=2 \
    "Apps" "" \
    "Apps/Terminal" "alacritty" \
    "Apps/Browser" "firefox" \
    "System" "" \
    "System/Reboot" "reboot" \
    "System/Power Off" "poweroff" \
| while read -r selection; do
    [ -n "$selection" ] && eval "$selection" &
done
