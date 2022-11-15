#!/bin/sh

# check to see is git command line installed in this machine
IS_GIT_AVAILABLE="$(git --version)"
if [[ $IS_GIT_AVAILABLE == *"version"* ]]; then
  echo "Git is Available"
else
  echo "Git is not installed"
  exit 1
fi


## copy .config files
cp --parents -r /etc/X11/xorg.conf.d/ $HOME/awesomebackupgpd

#cp -p -r ~/config-alacritty $HOME/dotfiles

if [[ $(ls -a | grep .config) == '' ]]; then
  mkdir .config
fi

rsync -Pra --delete ~/.config/{awesome,misc,alacritty,bottom,btop,cpupower_gui,cmus,dunst,fcitx5,feh,'gtk-2.0','gtk-3.0',mpv,nvim,picom,ranger,rofi,dmenu-frecency,zathura,touchegg,chrome-flags.conf} $HOME/awesomebackupsf/.config

cp -r ~/.doom.d/ $HOME/awesomebackupgpd/
# cp -r ~/.fonts/ $HOME/awesomebackupsf/

cp /etc/{environment,pacman.conf,vconsole.conf,tlp.conf,intel-undervolt.conf} $HOME/awesomebackupgpd/etc/

# copy other dot files
rsync -Pra $HOME/{'.gtkrc-2.0',.vimrc,.zshrc,.xprofile,.Xresources,.tmux.conf,.ticker.yaml} $HOME/awesomebackupgpd

# Check git status
gs="$(git status | grep -i "modified")"
# echo "${gs}"

# If there is a new change
if [[ $gs == *"modified"* ]]; then
  echo "push"
fi


# push to Github
git add -A;
git commit -m "New backup `date +'%Y-%m-%d %H:%M:%S'`";
git push origin main
