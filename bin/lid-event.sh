#!/bin/sh

# Add:
# event=button/lid*
# action=/home/ivan/bin/lid-event.sh
# in /etc/acpi/events/lid

STATE=$(cat /proc/acpi/button/lid/LID0/state | tr -s ' ' | cut -d ' ' -f 2)
case $STATE in
  "open")
    DISPLAY=:0 su ivan -c "xset dpms force on"
    ;;
  "closed")
    DISPLAY=:0 su ivan -c "xset dpms force off"
    ;;
esac

