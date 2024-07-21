#!/bin/bash


## Open/close widgets 
run_eww() {
	if [[ "$(eww get open-menu)" == false ]]; then
		eww open-many background menu
		eww update open-menu=true
		"$HOME/.config/eww/menu/scripts/weather_info" --getdata

	else
		eww update open-menu=false
		eww close background menu
	fi
}


if [[ "$1" == "menu" ]]; then
	run_eww
fi
