#!/usr/bin/env sh

rfkill unblock bluetooth
sleep 1
bluetoothctl power on
sleep 1
bluetoothctl connect 14:3F:A6:CA:3A:66
