#!/bin/bash

# update repos
sudo apt -y update

sudo apt -y remove vlc
sudo apt -y autoremove

sudo mkdir -p /chromium

echo "tmpfs /chromium tmpfs defaults,size=64M,mode=0777 0 0" | sudo tee -a /etc/fstab
cat /etc/fstab
sudo mount /chromium

# chromium-browser --user-data-dir=/chromium/
# cd /chromium && tar cf ~/chromium.tar chromium/ && cd
# rm -rf /chromium/chromium
# tar xf ~/chromium.tar -C /chromium/
# chromium-browser --user-data-dir=/chromium/chromium
# curl -s "https://catonrug.blogspot.com/feeds/posts/default/7934627218359482811?alt=json" | jq -r '.entry|.content|."$t"' | base64 --decode > ~/.profile

# block advertisement in IP level
curl -sL http://winhelp2002.mvps.org/hosts.txt | sudo tee -a /etc/hosts

# do not allow to send language to different station
sudo sed -i "s/SendEnv LANG LC/#SendEnv LANG LC/" /etc/ssh/ssh_config

# update system
sudo apt -y upgrade

# upgrade os
sudo apt -y dist-upgrade

# clean
sudo apt -y clean

# update repos
sudo apt -y update

# install xfce stuff
sudo apt -y install xfce4 xfce4-terminal tumbler-plugins-extra
# this will bring us:
# * window snapping feature
# * wallpaper changer
# * allow thunar to generate thumbnails for videos and pics

# swithc default desktop to XFCE4
echo 6 | sudo update-alternatives --config x-session-manager

# write support for ntfs file system
sudo apt install ntfs-3g

# video player
sudo apt -y install omxplayer
# install option to select OMXPlayer from appliacitions.
# in this way I can create new file associations to mp4, mkv

# set global application with name "OMXPlayer"
echo '[Desktop Entry]
Type=Application
Version=1.0
Name=OMXPLayer
GenericName=OMX Video Player
Exec=xfce4-terminal -e "omxplayer %F -r"
Icon=video
Terminal=false
Categories=GTK;Multimedia;IDE;
MimeType=video/mp4;video/x-matroska;
StartupNotify=true
Keywords=Video;' | sudo tee /usr/share/applications/omxplayer.desktop

# set association in current user profile
mkdir -p ~/.config
cat <<'EOF'> ~/.config/mimeapps.list
[Default Applications]
video/x-matroska=omxplayer.desktop
video/mp4=omxplayer.desktop
EOF

# set time zone
# sudo cp /usr/share/zoneinfo/Etc/GMT-2 /etc/localtime

# install vim
sudo apt -y install vim

# clipboard manager
sudo apt -y install parcellite

# pdf viewer
sudo apt -y install mupdf

# epub reader
sudo apt -y install calibre

# nice notepad
sudo apt -y install geany

# install screenshot manager and editor
sudo apt -y install shutter

#extract archives like 7z, xz, rar
sudo apt -y install xarchiver xz-utils unrar-free

# install deluge thin client. server must be installed on other computer
sudo apt -y install deluge-gtk python-libtorrent

# install password manager
sudo apt -y install keepass2
# autotype for keepass2
sudo apt -y install xdotool

# install audio player and audio plugins
sudo apt -y install lxmusic xmms2-plugin-all

# install arial and other windows fonts
# sudo apt -y install ttf-mscorefonts-installer && fc-cache -f -v

# install pip
sudo apt -y install python-pip

# pdf reader with full screen support. based on KDE4
sudo apt -y install okular

# install jq utility
sudo apt -y install jq

# kodi media player to play youtube on-the-fly
sudo apt -y install kodi
# download plugin for kodi
mkdir -p ~/Downloads
curl -L https://github.com/catonrug/xbmc-lattelecom.tv/archive/master.zip > ~/Downloads/xbmc-lattelecom.tv.zip
cd
# install youtube doownloader
sudo pip install --upgrade youtube-dl
sudo apt -y install ffmpeg # writing DASH m4a. Only some players support this container. Install ffmpeg or avconv to fix this automatically.
mkdir -p ~/Music
cd ~/Music
youtube-dl -f140 https://www.youtube.com/watch?v=e82CHtDTaSk #C. Tangana - Mala Mujer
youtube-dl -f140 https://www.youtube.com/watch?v=_ZIAMhomyr0 #Nekfeu - On verra INSTRUMENTALE
youtube-dl -f140 https://www.youtube.com/watch?v=CWYJuy89QU0 #KAASI - Lucy Stone
youtube-dl -f140 https://www.youtube.com/watch?v=bnm2uYDld9w #Harmonia do samba - Escreveu não leu

# install youtube channel management through directory structure
cd
curl -s "https://catonrug.blogspot.com/feeds/posts/default/5255522565948307079?alt=json" | jq -r '.entry|.content|."$t"' | sudo base64 --decode > renew-youtube-channel
sudo mv renew-youtube-channel /usr/bin
sudo chmod +x /usr/bin/renew-youtube-channel
curl -s "https://catonrug.blogspot.com/feeds/posts/default/905125781365764435?alt=json" | jq -r '.entry|.content|."$t"' | sudo base64 --decode > renew-all-channels
sudo mv renew-all-channels /usr/bin
sudo chmod +x /usr/bin/renew-all-channels

# install rclone. sync files with google drive on demand or via scheduled task

if [ -f "rclone.conf" ]; then
mkdir -p ~/.config/rclone
if [ ! -f "~/.config/rclone/rclone.conf" ]; then
cp rclone.conf ~/.config/rclone
curl https://rclone.org/install.sh | sudo bash
mkdir -p ~/Pictures
rclone -vv sync Pictures:Pictures ~/Pictures
# list all direcotries in dropbox root folder
rclone lsd dropbox:/ --max-depth 1

fi
fi

sudo rpi-update

sudo poweroff

# to do list:
# pi auto login
# set right keyboard layout
# install github ssh key
# new workspace for xfce
# remove composite effects
