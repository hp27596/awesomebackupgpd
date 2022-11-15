#!/usr/bin/env bash

chosen=$(echo -e "0. Performance\n1. 1600mhz\n2. 2400mhz" | dmenu -i -l 10 -p "Choose CPU Profile:")
if [[ $chosen = "0. Performance" ]]; then
    cpupower-gui pr Performance
elif [[ $chosen = "1. 1600mhz" ]]; then
    cpupower-gui pr 1600mhz
elif [[ $chosen = "2. 2400mhz" ]]; then
    cpupower-gui pr 2400mhz
fi
