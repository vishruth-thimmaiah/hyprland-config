#!/usr/bin/env bash
dir="$HOME/.config/hypr/launcher"
theme='main'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi
