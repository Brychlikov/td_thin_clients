#!/bin/bash

export DISPLAY=:0.0
export XAUTHORITY=/run/lightdm/user/xauthority

CONTROLLER_ADDR=192.168.1.15

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP: Monitor event detected" >> /var/log/monitor_events.log

# Optional: Check current monitor state
echo MONITORS DATA >> /var/log/monitor_events.log
echo trying query
sudo -u user xrandr --query | grep ' connected' >> /var/log/monitor_events.log
echo got here


killall -q vlc

# has as many elements as terminal has monitors
connected_monitors=$(sudo -u user xrandr --query | grep ' connected' | awk '{print $1}')
echo $connected_monitors



for x in $connected_monitors; do
    VLC_CMD="vlc rtmp://${CONTROLLER_ADDR}/live/$(hostname)-${x} --fullscreen --qt-fullscreen-screennumber=${x: -1} --loop --qt-minimal-view --qt-start-minimized --qt-notification=0 --qt-auto-raise=0"
    echo running $VLC_CMD | tee /var/log/monitor_events.log
    sudo -u user $VLC_CMD &
done
    


