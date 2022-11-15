#!/usr/bin/env bash

# This scripts open dotfiles from various locations for faster accessing.

# List config files path
declare -a options=(
    "Script Launcher - ~/.config/misc/dm-scriptlauncher.sh"
    "This file - ~/.config/misc/dm-opendot.sh"
    "AwesomeWM config - ~/.config/awesome/rc.lua"
    "AwesomeWM current theme - ~/.config/awesome/themes/holo/theme.lua"
    "Qtile config.py - ~/.config/qtile/config.py"
    "Emacs config.el - ~/.doom.d/config.el"
    "Emacs init.el - ~/.doom.d/init.el"
    "Emacs packages.el - ~/.doom.d/packages.el"
    "Dunstrc - ~/.config/dunst/dunstrc"
    "Alacritty - ~/.config/alacritty/alacritty.yml"
    "Neovim - ~/.config/nvim/init.vim"
    "Zsh Config - ~/.zshrc"
    "Xresources - ~/.Xresources"
    "Xprofile - ~/.xprofile"
    "Environment - /etc/environment"
    "Tmux - ~/.tmux.conf"
    "Picom - ~/.config/picom/picom.conf"
    "Tint2 - ~/.config/tint2/tint2rc"
    "Cava - ~/.config/cava/config"
    "Rofi - ~/.config/rofi/config.rasi"
)

# add number count
cnt=${#options[@]}
for ((i=0;i<cnt;i++)); do
    options[i]="$i. ${options[i]}"
done

# choose file
choice=$(printf '%s\n' "${options[@]}" | dmenu -i -l 20 -p 'Edit Script:')
chosen=$(printf "$choice" | awk '{print $NF}')
name=$(printf "$chosen" | awk -F '/' '{print $NF}')

# open file in a new emacs workspace. replace the command with your favorite editor, i.e vim '$chosen'
if [ "$chosen" != "" ]; then
    emacsclient -e '(progn (+workspace-new "'$name'")(+workspace-switch "'$name'")(find-file "'$chosen'"))'
    qtile cmd-obj -o group 2 -f toscreen
fi
