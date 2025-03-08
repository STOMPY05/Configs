#!/usr/bin/env sh

IMAGE="power-on.png"

### Change Image Per Script
sed --follow-symlinks -i "s|url(\"~/.config/icons/.*.png|url(\"~/.config/icons/rofi/$IMAGE|g" ~/.config/rofi/shared/image.rasi

### Import Current Theme
source "$HOME"/.config/rofi/shared/theme.bash
theme="$type/$style"

### Theme Elements
list_col='1'
list_row='6'

### Options
option_1="󰨇 Task Manager"
option_2="󰌾 Lock"
option_3="󰍃 Logout"
option_4="󰏤 Suspend"
option_5="󰜉 Reboot"
option_6="󰓛 Shutdown"
yes="Yes"
no="No"

### Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-dmenu \
		-markup-rows \
		-theme ${theme}
}

# Pass Variables To Rofi DMenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

### Confirmation CMD
confirm_cmd() {
	rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
		-theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are You Sure?' \
		-theme ${theme}
}

### Ask For Confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

### Confirm And Execute
confirm_run () {	
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi	
}

### Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		"$HOME/.config/scripts/launch_btop.sh"
	elif [[ "$1" == '--opt2' ]]; then
		"$HOME/.config/scripts/hyprlock_lock.sh"
	elif [[ "$1" == '--opt3' ]]; then
		confirm_run "pkill -15 -u $USER"
	elif [[ "$1" == '--opt4' ]]; then
		confirm_run 'playerctl pause' 'systemctl suspend'
	elif [[ "$1" == '--opt5' ]]; then
		confirm_run 'systemctl reboot'
	elif [[ "$1" == '--opt6' ]]; then
		confirm_run 'systemctl poweroff'
	fi
}

### Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
