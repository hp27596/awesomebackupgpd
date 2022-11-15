#!/usr/bin/env bash

choice=$(echo -e '1. Enable Turbo\n2. Disable Turbo' | dmenu -i -l 5 -p 'Choose Action:')

if [[ $choice = "1. Enable Turbo" ]]; then
    pkexec bash -c "echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo"
elif [[ $choice = "2. Disable Turbo" ]]; then
    pkexec bash -c "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
fi
