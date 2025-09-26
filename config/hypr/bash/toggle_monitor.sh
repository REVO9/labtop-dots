#!/bin/bash

dpmsStatus=$(hyprctl monitors | grep "dpmsStatus" | awk '{print $2}')

if [[ $dpmsStatus -eq 1 ]]; then
    echo "DPMS is enabled. Performing action for DPMS = 1."
    hyprctl dispatch dpms off
else
    echo "DPMS is disabled. Performing action for DPMS = 0."
    hyprctl dispatch dpms on
fi
