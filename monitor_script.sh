#!/bin/bash

export DISPLAY=:0.0
export XAUTHORITY=/run/lightdm/user/xauthority

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP: Monitor event detected" >> /var/log/monitor_events.log

# Optional: Check current monitor state
echo MONITORS DATA >> /var/log/monitor_events.log
xrandr --query | grep ' connected' >> /var/log/monitor_events.log


killall -q vlc

# has as many elements as terminal has monitors
connected_monitors=$(xrandr --query | grep ' connected' | awk '{print $1}')
echo $connected_monitors


for x in $connected_monitors; do
    echo "Trying to play ${x}.mp4 at ${x: -1}"
    sudo -u user vlc /home/user/Videos/${x}.mp4 --fullscreen --qt-fullscreen-screennumber=${x: -1} --loop --qt-minimal-view &
done
    


