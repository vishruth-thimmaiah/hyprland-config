#!/bin/bash

advert=false
volume=1
while true;do
	song=$(playerctl --player spotify metadata --format '{{title}}')
	if [[ -z "$song" ]]; then
		echo "Offline"
	else
		if [[ "$song" == "Advertisement" ]]; then
			if [[ "$advert" == false ]]; then
				volume="$(playerctl --player spotify volume)"
				playerctl --player spotify volume 0
				advert=true
			fi
		elif [[ "$advert" == true ]]; then
			playerctl --player spotify volume "$volume"
			advert=false
		fi
	fi
	sleep 1;
done
