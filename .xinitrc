#!/usr/bin/zsh
eval `dbus-launch --sh-syntax --exit-with-session`
# mpd &
# xscreensaver &
eval `gnome-keyring-daemon`  # SSH/GPG agent
exec mate-session &
exec awesome
