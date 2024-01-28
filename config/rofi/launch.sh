#!/usr/bin/env bash
dir="$HOME/.config/rofi"
theme='main'

## Run
if [[ $1 == "launcher" ]]; then
	if pgrep -x rofi; then
		killall rofi
	else
		rofi -show drun -theme "${dir}/${theme}.rasi"
	fi
elif [[ $1 == "clipboard" ]]; then
	var=$(cliphist list | rofi -dmenu -theme "$dir/cliphist.rasi" -display-columns 2)
	if [[ $var ]]; then
		cliphist decode <<<"$var" | wl-copy
	fi
fi
