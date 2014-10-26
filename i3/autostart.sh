#!/bin/bash
compton -b -Ff -D5 -I.1 -O.1 --backend glx &
nitrogen --restore &
dropboxd &
fcitx &
nm-applet &
# xfce4-power-manager &
(sleep 10; pnmixer ) &
