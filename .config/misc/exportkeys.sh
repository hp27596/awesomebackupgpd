#!/usr/bin/env bash

sleep 0.1
python ~/.config/qtile/exportkeys.py | column -L
echo
echo -n "Press any key to exit."
read -n 1
