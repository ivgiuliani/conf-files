#!/bin/bash
# xtrlock
killall -SIGUSR1 dunst # pause
i3lock -c "#300000" --dpms --ignore-empty-password
killall -SIGUSR2 dunst # resume

