#!/bin/bash


VFILE="/tmp/eww_launch.volume"
BFILE="/tmp/eww_launch.bright"

screenshot() {
	if [[ "$(eww active-windows | grep screenshot)" != "screenshot: screenshot" ]]; then
		eww open screenshot
	else
		sleep 0.2
		eww close screenshot
	fi
}

volume() {
	if [[ "$(eww active-windows | grep volume)" != "volume: volume" ]]; then
		touch "$VFILE"
		eww close brightness
		eww open volume
	fi
	volI="$( amixer -D pulse sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }' | tr -d '%')"
	eww  update current-volume="$volI"
	date +%s > "$VFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $VFILE)" ]]; then
		rm "$VFILE"
		eww close volume
	fi
}

brightness() {
	if [[ "$(eww active-windows | grep brightness)" != "brightness: brightness" ]]; then
		touch "$BFILE"
		eww open brightness
		eww close volume
	fi
	brightI="$(( $(brightnessctl g)*100 / $(brightnessctl m) ))"
	eww update current-brightness="$brightI"
	date +%s > "$BFILE"
	sleep 5
	if [[ $(("$(date +%s)" - 5)) -ge "$(cat $BFILE)" ]]; then
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
