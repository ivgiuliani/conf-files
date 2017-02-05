#!/bin/bash
CONTROL="/home/ivan/bin/control-backlight"
TMP_FILE="/tmp/screen_brightness"

grep -q close /proc/acpi/button/lid/*/state
if [ $? = 0 ]; then
  rm -f $TMP_FILE
  $CONTROL -get > $TMP_FILE
  $CONTROL -set 0
fi

grep -q open /proc/acpi/button/lid/*/state
if [ $? = 0 ]; then
  BRIGHTNESS=100
  if [ -f $TMP_FILE ]; then
    BRIGHTNESS=$(cat $TMP_FILE)
  fi
  $CONTROL -set $BRIGHTNESS
fi

