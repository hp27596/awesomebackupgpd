#!/bin/bash

# Simple script to handle a DIY shutdown menu. When run you should see a bunch of options (shutdown, reboot etc.)
#
# Requirements:
# - dmenu
# - systemd

chosen=$(echo -e "... [Cancel]\n0. Screen Off\n1. Logout\n2. Shutdown\n3. Reboot\n4. Suspend\n5. Lockscreen\n6. Hibernate" | dmenu -i -l 10 -h 20 -p "Choose Action:")
if [[ $chosen = "0. Screen Off" ]]; then
	xset dpms force off
elif [[ $chosen = "4. Suspend" ]]; then
	systemctl suspend
elif [[ $chosen = "1. Logout" ]]; then
	if [ $pgrep awesome ]; then
		echo 'awesome.quit()' | awesome-client
	elif [ $pgrep qtile ]; then
		echo 'shutdown()' | qtile shell
	else
		kill -9 -1 ## system agnostic but doesn't let applications close correctly, use if no other choice.
	fi
elif [[ $chosen = "2. Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "3. Reboot" ]]; then
	systemctl reboot
elif [[ $chosen = "5. Lockscreen" ]]; then
	gnome-screensaver-command -l
elif [[ $chosen = "6. Hibernate" ]]; then
	systemctl hibernate
fi
