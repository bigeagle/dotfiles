#!/bin/bash
compton -b -Ff -D5 -I.1 -O.1 --backend glx &
nitrogen --restore &
rofi &
cbatticon &
dropbox &
fcitx &
nm-applet &
blueman-applet &
(sleep 5; pnmixer) &
python3 -u /usr/bin/udevedu &>/tmp/udevedu.log &
