#!/usr/bin/env bash

MON=$(xrandr | grep " connected" | cut -f1 -d " ")
CURR=$(xrandr --current --verbose | grep Brightness | cut -f2 -d " ")
STEP=1

CURR=`echo "$CURR * 10 - 10" | bc`

extended_brightness () {
    if [[ "$1" == "up" ]] && [[ $(echo "$CURR < 5" | bc) == 1 ]]
    then
        NEW=`echo "$CURR + $STEP" | bc`
    elif [[ "$1" == "down" ]] && [[ $(echo "$CURR > -5" | bc) == 1 ]]
    then
        NEW=`echo "$CURR - $STEP" | bc`
    fi

    if [[ $NEW == '' ]]
    then
        echo "Out of range"
    else
        NEW=`echo "scale=1;($NEW + 10)/10" | bc`
        xrandr --output "$MON" --brightness "$NEW"
    fi
}

currbase=$(brightnessctl | grep Current | cut -f3 -d " ")

if [[ "$1" == "up" ]]
then
    if [[ $(echo "$CURR < 0" | bc) == 1 ]]
    then
        extended_brightness up
    else
        if [[ $currbase == 100 ]]
        then
            extended_brightness up
        else
            brightnessctl s +5%
        fi
    fi
    notify-send -t 2000 "Brightness Up" "$(brightnessctl | grep Current | cut -c 2-)\nCurrent Extended brightness: $(xrandr --current --verbose | grep Brightness | cut -f2 -d " ")"
elif [[ "$1" == "down" ]]
then
    if [[ $(echo "$CURR > 0" | bc) == 1 ]]
    then
        extended_brightness down
    else
        if [[ $currbase == 0 ]]
        then
            extended_brightness down
        else
            brightnessctl s 5%-
        fi
    fi
    notify-send -t 2000 "Brightness Down" "$(brightnessctl | grep Current | cut -c 2-)\nCurrent Extended brightness: $(xrandr --current --verbose | grep Brightness | cut -f2 -d " ")"
fi

# echo "Extended brightness:" $(xrandr --current --verbose | grep Brightness | cut -f2 -d " ")
