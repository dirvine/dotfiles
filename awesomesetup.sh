#!/bin/bash
echo "[GNOME Session]
Name=Awesome session
RequiredComponents=awesome;gnome-settings-daemon;
DesktopName=Awesome" > /usr/share/gnome-session/sessions/awesome.session
echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Awesome
Comment=The awesome launcher!
TryExec=awesome
Exec=awesome" > /usr/share/applications/awesome.desktop
echo "[Desktop Entry]
Name=Awesome GNOME
Comment=Dynamic window manager
Exec=gnome-session --session=awesome
TryExec=awesome
Type=Application
X-LightDM-DesktopName=Awesome GNOME
X-Ubuntu-Gettext-Domain=gnome-session-3.0" >  /usr/share/xsessions/awesome-gnome.desktop
echo "[Desktop Entry]
Type=Application
Name=GNOME Settings Daemon
Exec=/usr/lib/gnome-settings-daemon/gnome-settings-daemon-localeexec
OnlyShowIn=GNOME;Unity;Awesome;
NoDisplay=true
X-GNOME-Autostart-Phase=Initialization
X-GNOME-Autostart-Notify=true
X-GNOME-AutoRestart=true
X-Ubuntu-Gettext-Domain=gnome-settings-daemon" > /etc/xdg/autostart/gnome-settings-daemon.desktop
dconf write /org/gnome/settings-daemon/plugins/cursor/active false
for i in `ls  /usr/share/applications/gnome*panel*`;do sudo sed -ri 's/OnlyShowIn=/OnlyShowIn=Awesome;/'  $i  ;done
