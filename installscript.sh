#!/usr/bin/env bash

# Update system
sudo pacman -Syyu

# Install yay
sudo pacman -S git
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R hp:hp ./yay-git
cd yay-git
makepkg -si

# Copy pacman config
cd ~/awesomebackup
# copy dotfiles
mkdir -pv $HOME/.config
cp -r .doom.d ~/
# cd ~/awesomebackup/
# cp -r .fonts ~/
# sudo cp -r ./etc/ /
sudo rsync -av --progress ./etc/ /etc --exclude X11
sudo cp pfetch /usr/local/bin/
rsync -av --progress ./.config/ $HOME/.config --exclude .git
cp ./{.ticker.yaml,.tmux.conf,.xprofile,.vimrc,.Xresources,.zshrc,.gtkrc-2.0} ~/

# Install essential packages
yay -S emacs zsh intel-media-driver intel-gpu-tools libva-utils thunar sshfs picom dmenu xorg-xinput brightnessctl alsa-utils seahorse polkit-gnome gnome-keyring libgnome-keyring bluez bluez-tools bluez-utils speedtest-cli lxappearance-gtk3 dunst perl playerctl pnmixer xautolock cmake fzf feh cmus gnome-disk-utility python-pip python iw net-tools htop mpv tk ctags nodejs npm xclip xsel yarn firewalld picom pacman-contrib neovim gvfs gvfs-mtp adobe-source-code-pro-fonts tlp tlp-rdw cargo fuse-exfat onboard acpi acpid blueman tumbler locate man pavucontrol libwacom xf86-input-wacom thermald powertop wget thunar-archive-plugin zip xarchiver

# tlp setup
sudo systemctl enable tlp
sudo systemctl mask systemd-rfkill.service systemd-rfkill.socket
sudo tlp start
tlp-rdw

# Install pulseaudio or pipewire. My gpd pocket 2 somehow randomly only works with either one on different distros.
# pipewire
# yay -S pipewire pipewire-pulse pipewire-alsa lib32-pipewire
# systemctl --user --daemon-reload
# systemctl --user enable pipewire pipewire.socket

# pulseaudio
#yay -S pulseaudio-bluetooth pulseaudio pulseaudio-alsa pulseaudio-ctl lib32-libpulse pulseaudio-qt
#systemctl --user --daemon-reload
#systemctl --user enable pulseaudio pulseaudio.socket

# Install personal packages
yay -S interception-tools nextcloud-client flameshot ncdu steam ardour fortune-mod aircrack-ng bully reaver tmux libreoffice-still metasploit cowpatty wireshark-qt termshark macchanger pixiewps john android-sdk-platform-tools nerd-fonts-jetbrains-mono krita xorg-fonts gucharmap qbittorrent rustscan cpupower-gui wine-staging bottom vlc tldr lutris fcitx5 fcitx5-gtk fcitx5-qt fcitx5-unikey kcm-fcitx5 btop clipmenu gparted pass pass-otp sxiv scrcpy qutebrowser trash-cli kdeconnect zathura zathura-pdf-mupdf easytag gnome-power-manager yt-dlp gthumb qalculate-gtk galculator hashcat shotwell kate bettercap pyenv zaproxy audacious rofi qt5ct gnome-themes-extra adwaita-qt5 adwaita-qt6 cpupower lmms


# Install AUR packages
yay -S cava cmus-notify google-chrome ncmatrix python-pulsectl ticker timeshift-bin noto-fonts-emoji-apple mangohud-git ttf-unifont ttf-font-awesome otf-font-awesome protonvpn goverlay ttf-ubuntu-font-family ttf-ms-fonts routersploit-git colorpicker tlpui ttf-iosevka ueberzug xidlehook systemd-boot-pacman-hook pass-update intel-opencl-runtime mdk3 hashid pngcheck ranger-git ttf-ubuntu-font-family adwaita-dark intel-undervolt

# untested autoconfirm solution. used only when I'm sure about all the packages above. Needs testing
# echo y | LANG=C yay --noprovides --answerdiff None --answerclean None --mflags "--noconfirm" $PKGNAMe

# gnome-screensaver nuclear-player-bin

# virt manager
yay -S virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft bridge-utils openbsd-netcat
sudo systemctl enable --now libvirtd
sudo usermod -G libvirt -a $USER
# sudo firewall-cmd --zone=libvirt --add-port=12345/tcp #open more ports from vm
# sudo systemctl restart firewalld

# Post installation
# refresh font cache
# fc-cache -fv

# install and move to zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# dark theme for qbittorrent
wget https://github.com/dracula/qbittorrent/raw/master/qbittorrent.qbtheme

# pip packages
sudo pip install python-nmap
pip install wheel pyxdg iwlib

# enable bluetooth and other systemd services
sudo modprobe btusb
sudo systemctl enable bluetooth cronie firewalld acpid thermald
sudo systemctl start bluetooth cronie firewalld thermald

# Additional packages

# dmenu fork
cd ~
git clone https://github.com/hp27596/dmenu-distrotube-fork
cd dmenu-distrotube-fork
sudo make clean install
cd ~

# wifite fork
cd ~
git clone https://github.com/kimocoder/wifite2
cd wifite2
pip install -r requirements.txt
sudo pip install python-nmap
sudo python setup.py install
make help
cd ~

# neovim plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Run :PlugInstall

# doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
~/.emacs.d/bin/doom sync
ln -s /mnt/SDcard/Nextcloud/authinfo.gpg ~/.emacs.d/.local/etc/
gpg --import /mnt/SDcard/Nextcloud/{peterpub.gpg,petersec.gpg}

# caffeinate
cargo install --git https://github.com/rschmukler/caffeinate
sudo cp ~/.cargo/bin/caffeinate /usr/local/bin/

# grub theme
# cd ~
# git clone --depth 1 https://gitlab.com/VandalByte/darkmatter-grub-theme.git && cd darkmatter-grub-theme
# sudo python3 darkmatter-theme.py --install
# cd ~

# change shell
sudo chsh -s /usr/bin/zsh
