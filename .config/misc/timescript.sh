#!/usr/bin/env bash
upcount=$(mktemp)
ispeed=$(mktemp)

(checkupdates | wc -l) > "${upcount}" &
(speedtest-cli | grep load:) > "${ispeed}" &

# neofetch
pfetch
# uname -a
date
curl -s wttr.in | head -n 7
echo
echo -n "Local IPv4: " && ip addr show wlan0 | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'
echo -n "Public IPv4: " && curl -s -m 5 icanhazip.com
echo

echo "Checking Arch Linux Updates..."
wait
echo "---------"
echo "$(<$upcount) available updates"
echo
# fortune
echo "Checking internet speed..."
wait
echo "---------"
echo "$(<$ispeed)"

echo
echo -n "Press any key to exit."
read -n 1
