#!/bin/bash
compton -b -Ff -D5 -I.1 -O.1 --backend glx &
nitrogen --restore &
dropboxd &
fcitx &
nm-applet &
# xfce4-power-manager &
python2 -u ~/.local/bin/udevedu &>/tmp/udevedu.log &
(sleep 15; pnmixer ) &
