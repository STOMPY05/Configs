#!/usr/bin/env sh

source $HOME/.config/scripts/setup.sh 

if ! pgrep -f "$MY_TERMINAL --title tuinetwork"; then
    $MY_TERMINAL --title 'tuinetwork' -e tui-network
fi
