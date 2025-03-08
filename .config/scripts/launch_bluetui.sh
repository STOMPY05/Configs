#!/usr/bin/env sh

source $HOME/.config/scripts/setup.sh 

if ! pgrep -f "$MY_TERMINAL --title bluetui"; then
    $MY_TERMINAL --title 'bluetui' -e bluetui
fi
