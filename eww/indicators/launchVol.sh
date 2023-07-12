#!/bin/bash

VFILE="$HOME/.cache/eww_launch.volume"
BFILE="$HOME/.cache/eww_launch.volume"
CFG="$HOME/.config/eww/indicators"

## Open widgets
if [[ "$1" == vol ]]; then
	## Launch or close widgets accordingly
	touch "$VFILE"
	eww --config "$CFG" open vol
	volI="$( amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	eww --config "$CFG" update volumeInfo="$volI"
	date +%s > "$VFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $VFILE)" ]]; then
		eww --config "$CFG" close vol
		rm "$VFILE"
	fi
elif [[ "$1" == bright ]]; then
	## Launch or close widgets accordingly
	touch "$BFILE"
	eww --config "$CFG" open bright
	brightI="$(light)"
	eww --config "$CFG" update brightnessInfo="$brightI"
	date +%s > "$BFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $BFILE)" ]]; then
		eww --config "$CFG" close bright
		rm "$BFILE"
	fi
fi
