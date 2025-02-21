#!/usr/bin/env sh

### Rofi : Launcher (Modi Drun, Run, File Browser, Window)


dir="$HOME/.config/rofi/drun/"
theme='style'

### Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
