#!/usr/bin/env bash

chosen=$(echo -e "1. Enable Caffeinate Indefinitely\n2. Enable Caffeinate For X Minutes\n3. Disable Caffeinate" | dmenu -i -l 5 -p "Choose Action:")

if [[ $chosen == *"1."* ]]; then
    killall caffeinate
    caffeinate &
elif [[ $chosen == *"2."* ]]; then
    minute=$(echo "" | dmenu -i -p "Enter Minutes:")
    second=$(($minute*60))
    killall caffeinate
    caffeinate --timer $second &
elif [[ $chosen == *"3."* ]]; then
    killall caffeinate
fi

echo 'caffeine_timer:emit_signal("timeout")' | awesome-client
