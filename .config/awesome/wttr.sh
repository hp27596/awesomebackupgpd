#!/bin/sh

weather=$(curl -s wttr.in/Hanoi\?format="%l+%c%t+%f" | awk -F ', |' '!($2="")' | tr -d , | tr -s " ")
if [[ $weather == '' ]]; then
    echo "No Weather Information"
else
    echo $weather
fi
