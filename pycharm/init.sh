#!/bin/bash
Xvfb +extension RANDR :0 -ac -screen 0 1280x720x16 > /dev/null &
sleep 5

x11vnc -forever -create -display :0 >/dev/null 2>&1 &
/pycharm-community-2016.2/bin/pycharm.sh &
sleep 10

WID=`xwininfo -display :0 -root -children | grep "Complete Installation" | grep -Eo '0x[a-z0-9]+'`
xdotool windowmove $WID 0 0
xdotool windowsize $WID 1280 720

websockify --web /noVNC 80 localhost:5900 
