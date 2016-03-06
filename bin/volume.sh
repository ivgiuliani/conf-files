#!/bin/bash
VAL=$1
pactl set-sink-volume 0 "$VAL"
#pactl set-sink-volume 1 "$VAL"
VOLUME=$(pacmd dump-volumes | grep Sink | sed 's/>>>//g' | awk '{ print $8 }' | paste -sd " ")

dbus-send --type=method_call --reply-timeout=1000 \
  --dest=org.freedesktop.Notifications \
  /org/freedesktop/Notifications  org.freedesktop.Notifications.Notify \
  string:"volume_thing" \
  uint32:1 \
  string:'app_icon' \
  string:"Volume" \
  string:"$VOLUME" \
  array:string:"" \
  dict:string:string:"",""\
  int32:1000

