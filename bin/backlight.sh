#!/bin/bash
~/bin/control-backlight $*
notify-desktop

/home/ivan/bin/notify-desktop \
  -u low \
  -t 100 \
  -r 10327 \
  `~/bin/control-backlight -get | xargs printf '%.f'`
