#! /bin/bash

#define icons for workspaces 1-9
ic=(0         )

#initial check for occupied workspaces
for num in $(hyprctl workspaces | grep ID | sed 's/()/(1)/g' | awk 'NR>1{print $1}' RS='(' FS=')'); do 
  export o"$num"="$num"
done
 
#initial check for focused workspace
for num in $(hyprctl monitors | grep active | sed 's/()/(1)/g' | awk 'NR>1{print $1}' RS='(' FS=')'); do 
  export f"$num"="$num"
  export fnum=f"$num"
done

workspaces() {

	if [[ ${1:0:15} == "createworkspace" ]]; then #set Occupied workspace
		num=${1:17}
		export o"$num"="$num"
		export f"$num"="$num"

	elif [[ ${1:0:16} == "destroyworkspace" ]]; then #unset unoccupied workspace
		num=${1:18}
		unset -v o"$num" f"$num"

	elif [[ ${1:0:9} == "workspace" ]]; then #set focused workspace
		unset -v "$fnum"
		num=${1:11}
		export f"$num"="$num"
		export fnum=f"$num"
		ic=(0         )
		ic["$num"]=
	fi

	#output eww widget
	echo "(box	:class \"bar-workspace\"	:orientation \"v\" :spacing 0 :space-evenly \"true\" 	\
		(button :onclick \"hyprctl dispatch workspace 1\" :class \"w$o1$f1\" \"${ic[1]}\") \
		(button :onclick \"hyprctl dispatch workspace 2\" :class \"w$o2$f2\" \"${ic[2]}\") \
		(button :onclick \"hyprctl dispatch workspace 3\" :class \"w$o3$f3\" \"${ic[3]}\") \
		(button :onclick \"hyprctl dispatch workspace 4\" :class \"w$o4$f4\" \"${ic[4]}\") \
		(button :onclick \"hyprctl dispatch workspace 5\" :class \"w$o5$f5\" \"${ic[5]}\") \
		(button :onclick \"hyprctl dispatch workspace 6\" :class \"w$o6$f6\" \"${ic[6]}\") \
		(button :onclick \"hyprctl dispatch workspace 7\" :class \"w$o7$f7\" \"${ic[7]}\") \
		(button :onclick \"hyprctl dispatch workspace 8\" :class \"w$o8$f8\" \"${ic[8]}\") \
		(button :onclick \"hyprctl dispatch workspace 9\" :class \"w$o9$f9\" \"${ic[9]}\") \
		)"
	}

workspaces

socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r event; do 
workspaces "$event"
done
