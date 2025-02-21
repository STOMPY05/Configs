#!/bin/bash

### Initialize Variables
VAR1=10
VAR2=20
VAR3=0
VAR4=0
VAR5=0
VAR6=0

while true; do
    ### Show YAD Menu
    output=$(yad --form \
        --on-top \
        --borders=30 \
        --title="Yad - HyprIdle Settings" \
        --text-align=center --text="<b><u>HyprIdle Settings</u></b>\n"\
        --field="<b>Dim Screen After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR1" \
        --field=" :LBL" \
        --field="<b>Dim Keyboard Brightness After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR2" \
        --field=" :LBL" \
        --field="<b>Turn Off Screen After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR3" \
        --field=" :LBL" \
        --field="<b>Lock Screen After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR4" \
        --field=" :LBL" \
        --field="<b>Turn Off Display(s) After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR5" \
        --field=" :LBL" \
        --field="<b>Suspend Computer After: (0 = Disabled)</b>:LBL" \
        --field="Duration (Seconds) :NUM" "$VAR5" \
        --field=" :LBL" \
        --buttons-layout="center" --button="yad-cancel" --button="yad-apply" --button="yad-ok")

    ### Handle Button Clicks
    button=$?
    values=$(echo "$output" | awk -F '|' '{print $1, $2}')
    read -r VAR1 VAR2 <<< "$values"

    case $button in
        0)  ### Cancel Button
            exit 1
            ;;
        1)  ### Apply Button
            echo "VAR1=$VAR1" > variables.txt
            #echo "VAR2=$VAR2" >> variables.txt
            ;;
        2)  ### Cancel Button
            exit 1
            ;;
    esac
done
