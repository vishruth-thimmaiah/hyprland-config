#!/bin/bash


## Open/close widgets 
run_eww() {
	if [[ "$(eww get open-menu)" == false ]]; then
		eww open-many background menu
		eww update open-menu=true
		"$HOME/.config/eww/menu/scripts/weather_info" --getdata

	else
		eww update open-menu=false
		sleep 0.4
		eww close background menu
	fi
}


if [[ "$1" == "menu" ]]; then
	run_eww
elif [[ "$1" == "screenshot" ]]; then
	if [[ "$(eww get screenshot_rev)" == false ]]; then
		eww open screenshot
		eww update screenshot_rev=true
	else
		eww update screenshot_rev=false
		sleep 1
		eww close screenshot
	fi
fi
