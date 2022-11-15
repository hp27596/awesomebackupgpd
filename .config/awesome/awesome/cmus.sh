#!/usr/bin/env bash

name=$(cmus-remote -Q | grep title | cut -d " " -f3-)

if [ ${#name} -gt 23 ]
then
    name=$(printf '%.20s...\n' "$name")
else
    name=$(printf '%s\n' "$name")
fi

status=$(cmus-remote -Q | grep status | awk '{print $2}')

if [[ "$status" == "playing" ]]; then
    echo " $name"
else
    echo " $name"
fi
