#!/bin/bash


VFILE="/tmp/eww_launch.volume"
BFILE="/tmp/eww_launch.bright"

screenshot() {
	if [[ "$(eww get screenshot_rev)" == false ]]; then
		eww open screenshot
		eww update screenshot_rev=true
	else
		eww update screenshot_rev=false
		sleep 0.2
		eww close screenshot
	fi
}

volume() {
	if [[ "$(eww get volume_rev)" == false ]]; then
		touch "$VFILE"
		eww open volume
		eww update volume_rev=true
		eww update brightness_rev=false
	fi
	volI="$( amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	eww  update current-volume="$volI"
	date +%s > "$VFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $VFILE)" ]]; then
		eww update volume_rev=false
		rm "$VFILE"
	fi
}

brightness() {
	if [[ "$(eww get brightness_rev)" == false ]]; then
		touch "$BFILE"
		eww open brightness
		eww update brightness_rev=true
		eww update volume_rev=false
	fi
	brightI="$(light)"
	eww update current-brightness="$brightI"
	date +%s > "$BFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $BFILE)" ]]; then
		eww update brightness_rev=false
		eww close brightness
		rm "$BFILE"
	fi
}


if [[ "$1" == "screenshot" ]]; then
	screenshot
elif [[ "$1" == "volume" ]]; then
	volume
elif [[ "$1" == "brightness" ]]; then
	brightness
fi
