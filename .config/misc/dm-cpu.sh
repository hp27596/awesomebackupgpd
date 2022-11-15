#!/usr/bin/env bash

options=($(cpupower-gui pr | tail -n +2 | cut -d" " -f2))

# cnt=${#options[@]}
# for ((i=0;i<cnt;i++)); do
#     options[i]="$i. ${options[i]}"
# done

# chosen=$(echo -e "0. Performance\n1. Balanced\n2. Single" | dmenu -i -l 10 -p "Choose CPU Profile:")

chosen=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -p 'Choose CPU Profile:')
cpupower-gui pr $chosen



# if [[ $chosen = "0. Performance" ]]; then
#     cpupower-gui pr Performance
# elif [[ $chosen = "1. Balanced" ]]; then
#     cpupower-gui pr Balanced
# elif [[ $chosen = "2. Single" ]]; then
#     cpupower-gui pr Single
# fi
