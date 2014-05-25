 #!/usr/bin/env bash
eval `dbus-launch --sh-syntax --exit-with-session`
gnome-settings-daemon &      # handles themes, starts gnome-screensaver. You may have to use gconf to disable it setting the background.
nm-applet &                  # assuming you're using Network Manager
pidgin &                     # if you're using pidgin. You can really put any programs here.
gnome-power-manager &        # for laptops and stuff
gnome-sound-applet &       # for mounting CDs, USB sticks, and such
eval `gnome-keyring-daemon`  # SSH/GPG agent
exec awesome &
exec ck-launch-session gnome-session # ck-launch-session is advised for the dbus stuff to work fine. */
