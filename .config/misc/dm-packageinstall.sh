#!/usr/bin/env sh

terminal='alacritty' #replace with your terminal of choice
action=$(echo -e "1. Install a Package\n2. Uninstall a Package" | dmenu -i -l 2 -p 'Choose action:')
if [[ $action == *"1"* ]]; then
    notify-send "Querying Package Database"
    choice=$(yay -Slq | dmenu -i -l 20 -p 'Choose package:')

    if [[ $choice ]]; then
        update=$(echo -e "1. Yes\n2. No (Not Recommended)" | dmenu -i -l 2 -p 'Would you like to update your system first?')
        if [[ $update == *"1"* ]]; then
            notify-send "Updating system and installing package $choice"
            $terminal --hold -e sh -c "yay -Syu $choice && $SHELL"
        elif [[ $update == *"2"* ]]; then
            notify-send "Installing package $choice"
            $terminal --hold -e sh -c "yay -S $choice && $SHELL"
        fi
    fi
elif [[ $action == *"2"* ]]; then
    notify-send "Listing All User Installed Packages"
    sleep 1
    choice=$(yay -Qqe | dmenu -i -l 20 -p 'Choose package:')

    if [[ $choice ]]; then
        notify-send "Uninstalling package $choice"
        $terminal --hold -e sh -c "yay -Rns $choice ; $SHELL"
    fi

fi
