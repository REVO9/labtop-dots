#!/usr/bin/env bash

state=$(rfkill list bluetooth | grep -i 'Soft blocked:' | awk '{print $3}')

if [ "$state" = "yes" ]; then
    bluetoothctl devices | grep Device | awk '{print }' | bluetoothctl disconnect
    rfkill unblock bluetooth
else
    rfkill block bluetooth
fi
