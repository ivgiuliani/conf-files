#!/bin/sh

set -e

rm -f /tmp/lock.log

# Reset the usb-c port after standby because of a bug on the usb hub on the LG monitor
# https://www.reddit.com/r/Monitors/comments/9jy2zi/lg_27uk850_usbc_not_working_correctly/
# https://www.lgcommunity.us.com/discussion/2019/usb-hub-and-display-itself-disconnect-when-coming-from-power-saving-mode-usb-c
echo '[before] uhubctl' >> /tmp/lock.log
while [ $(sudo uhubctl | tee -a /tmp/lock.log | grep -q "No compatible smart hubs detected") ]; do
  echo "No match"
  sleep 0.2
done
echo '[after] uhubctl' >> /tmp/lock.log

