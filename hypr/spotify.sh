#!/bin/bash

advert=false
volume=1
oldsong=""
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
		# if [[ "$song" != "$oldsong" ]]; then
		# 	wget -4 "$(spoty art)" -q -O /tmp/.music_cover.jpg
		# 	oldsong="$song"
		# fi
			
	fi
	sleep 1;
done
