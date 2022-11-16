#!/usr/bin/env sh

action=$(echo -e "1. Install a Package\n2. Uninstall a Package" | dmenu -i -l 2 -p 'Choose action:')
if [[ $action == *"1"* ]]; then
    notify-send "Querying Package Database"
    choice=$(yay -Slq | dmenu -i -l 20 -p 'Choose package:')

    if [ $choice ]; then
        alacritty --hold -e sh -c "yay -Syu $choice && $SHELL"
    fi
elif [[ $action == *"2"* ]]; then
    notify-send "Listing All User Installed Packages"
    sleep 1
    choice=$(yay -Qqe | dmenu -i -l 20 -p 'Choose package:')

    if [ $choice ]; then
        alacritty --hold -e sh -c "yay -Rns $choice ; $SHELL"
    fi

fi
