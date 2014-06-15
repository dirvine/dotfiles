#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "you must type 'screen_saver on' or 'screen_saver off'"
  exit
fi

if [ $1 = "off" ]; then
  #Disable modes
  /usr/bin/xset -dpms &
  /usr/bin/xset s off &
elif [ $1 = "on" ]; then
  #Re-enable modes
  /usr/bin/xset dpms
  /usr/bin/xset s on
else 
  echo "you must type 'screen_saver on' or 'screen_saver off'"
fi
