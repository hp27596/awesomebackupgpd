#!/bin/sh

word=$(cat ~/.config/misc/word.txt | dmenu -i -l 15)

if [[ $word != "" ]]; then
    printf $word | xclip -selection c && notify-send -t 2000 "\"$word\" copied to clipboard"
fi
