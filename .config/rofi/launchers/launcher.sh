#!/usr/bin/env sh

dir="$HOME/.config/rofi/launchers/"
theme='style'

## Run
rofi \
    -show drun \
    -disable-history \
    -theme ${dir}/${theme}.rasi
