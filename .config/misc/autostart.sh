#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

# tint2 &
xcalib ~/.config/misc/LT7911D.icm &

#starting utility applications at boot time
# xautolock -time 10 -locker 'slock' -detectsleep -killtime 12 -killer "systemctl suspend" &
xidlehook --not-when-fullscreen --not-when-audio --timer 600 'slock' '' --timer 900 'systemctl suspend' '' --socket "/tmp/xidlehook.sock" &

\emacs --daemon &
nextcloud &
fcitx5 &
# gnome-screensaver &
blueman-applet &
# caffeine &
picom --config ~/.config/picom/picom.conf &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# dunst &
clipmenud &
touchegg &
# onboard &
# feh --bg-fill ~/.config/qtile/1099421.png
# galaxybudsclient &
# volumeicon &
nm-applet &

sleep 2
alacritty &
run google-chrome-stable &
# run steam &

tmux kill-server &
sleep 1
alacritty -t tmux -e tmux &

# sh ~/.config/qtile/scripts/batterynotification.sh &

# python ~/pyscripts/nucleartoast.py &

# run nuclear &

# wait for emacs daemon to start
while [[ $(pgrep emacsclient) = '' ]]
do
    sleep 2
    emacsclient -c &
done
