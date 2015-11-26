#!/usr/bin/env bash
eval `dbus-launch --sh-syntax --exit-with-session`
nm-applet &                  # assuming you're using Network Manager
mpd &
xscreensaver &
eval `gnome-keyring-daemon`  # SSH/GPG agent
exec awesome  
