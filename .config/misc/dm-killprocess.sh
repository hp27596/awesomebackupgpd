#!/bin/sh

pid=$(ps -u $USER -o pid,%mem,%cpu,comm | sort -b -k2 -r | sed -n '1!p' | dmenu -i -l 15 -p "Kill Process:"| awk '{print $1}')
name=$(ps -p $pid -F | tail -1 | awk '{out=""; for(i=11;i<=NF;i++){out=out" "$i}; print out}')
kill -15 $pid 2>/dev/null && notify-send -t 5000 "Killed Process" "$name"
