#!/bin/bash
xbacklight $*
notify-desktop

/home/ivan/bin/notify-desktop \
  -u low \
  -t 100 \
  -r 10327 \
  `xbacklight -get | xargs printf '%.f'`
