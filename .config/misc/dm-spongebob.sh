#!/bin/bash

word=$(echo "" | dmenu -i -p 'sPOngEbOb sAys:')
output=$(~/.local/bin/spongebobsay -n "$word" | tr -d '\n')

printf "$output" | xclip -selection clipboard
notify-send "$output"
