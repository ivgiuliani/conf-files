#!/bin/bash
# xtrlock
SCREENSHOT_PATH="/tmp/screenshot.png"

import -window root -quality 50 -resize 25%x25% $SCREENSHOT_PATH

convert $SCREENSHOT_PATH \
  \( +clone -gravity south -filter Gaussian -define filter:sigma-5.0 -blur 0x8 \) \
  -composite \( +clone +level-colors Black -matte -channel a -fx 0.1 \) \
  -composite $SCREENSHOT_PATH
convert $SCREENSHOT_PATH -resize 400%x400% $SCREENSHOT_PATH

killall -SIGUSR1 dunst # pause
i3lock -c "#300000" --dpms --ignore-empty-password -i $SCREENSHOT_PATH
killall -SIGUSR2 dunst # resume

rm -f $SCREENSHOT_PATH
sync
