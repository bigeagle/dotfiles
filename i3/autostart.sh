#!/bin/bash
compton -b -Ff -D5 -I.1 -O.1 --backend glx &
nitrogen --restore &
pnmixer &
dropboxd &
fcitx &
nm-applet &
xfce4-power-manager &
