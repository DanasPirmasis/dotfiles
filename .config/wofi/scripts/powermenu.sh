#!/bin/bash

entries="⭮ Reboot\n⏻ Shutdown\n⇠ Logout\n⏾ Suspend"

selected=$(echo -e $entries|wofi --width 250 --height 220 --dmenu ~/.config/wofi/style.css --hide_search=true --hide-scroll --cache-file /dev/null | awk '{print tolower($2)}')

case $selected in
  logout)
    exec hyprctl dispatch exit NOW;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
