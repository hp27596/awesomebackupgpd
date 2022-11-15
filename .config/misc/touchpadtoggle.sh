#!/usr/bin/env bash

touchpad=$(xinput list | grep Touchpad)

if [[ "$touchpad" == *"floating"* ]]; then
    id=$(xinput list | grep Touchpad | awk '{ print $6 }' | grep -o '..$')
    xinput reattach $id 2
    notify-send -t 2000 "Touchpad enabled"
else
    id=$(xinput list | grep Touchpad | awk '{ print $7 }' | grep -o '..$')
    xinput float $id
    notify-send -t 2000 "Touchpad disabled"
fi
