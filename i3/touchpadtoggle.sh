#!/bin/bash
onOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')

if [[ $onOff = "1" ]]; then
   onOffText="Disabled"
else
   onOffText="Enabled"
fi

xinput set-int-prop "DualPoint Stick" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "DualPoint Stick" "Evdev Wheel Emulation Button" 8 2
xinput set-prop "DualPoint Stick" "Evdev Middle Button Timeout" 50
xinput set-prop "DualPoint Stick" "Evdev Wheel Emulation Timeout" 150
xset m 10 2
synclient PalmMinWidth=1
synclient PalmMinZ=1

synclient "TouchpadOff=$onOff"
notify-send "Touchpad $onOffText"
