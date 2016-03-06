#!/bin/bash
VOLUME=$(pacmd dump-volumes | grep Sink | sed 's/>>>//g' | awk '{ print $8 }' | paste -sd " ")
echo $VOLUME
