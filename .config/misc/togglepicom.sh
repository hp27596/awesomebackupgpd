#!/usr/bin/env bash

if ps aux | pgrep picom > /dev/null
then
   killall picom
else
   picom --config ~/.config/picom/picom.conf --experimental-backends -CGb
fi
