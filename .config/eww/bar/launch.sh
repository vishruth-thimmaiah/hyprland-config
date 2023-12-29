#!/bin/bash

VFILE="$HOME/.cache/eww_launch.volume"
BFILE="$HOME/.cache/eww_launch.bright"

if [[ "$1" == vol ]]; then
	touch "$VFILE"
	eww update volume_bar=true
	eww update bright=false
	volI="$( amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	eww  update current-volume="$volI"
	date +%s > "$VFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $VFILE)" ]]; then
	eww update volume_bar=false
		rm "$VFILE"
	fi

elif [[ "$1" == bright ]]; then
	touch "$BFILE"
	eww update bright=true
	eww update volume_bar=false
	brightI="$(light)"
	eww update current-brightness="$brightI"
	date +%s > "$BFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $BFILE)" ]]; then
		eww update bright=false
		rm "$BFILE"
	fi
fi
