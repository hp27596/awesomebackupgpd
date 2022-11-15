#!/usr/bin/env bash


if [ $(pgrep rot8) ]; then
    killall rot8
    notify-send -t 2000 "Rotation Locked"
else
    # rot8 --sleep 3000 --touchscreen 'ELAN9038:00 04F3:2A1C' --display eDP1 &
    rot8 --touchscreen 'ELAN9038:00 04F3:2A1C Stylus Pen (0)' 'ELAN9038:00 04F3:2A1C Stylus Eraser (0)' 'ELAN9038:00 04F3:2A1C' --display eDP1 &
    notify-send -t 2000 "Rotation Unlocked"
fi

echo 'rot_timer:emit_signal("timeout")' | awesome-client
