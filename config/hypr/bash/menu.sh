#!/usr/bin/env bash

hyprctl keyword layerrule unset, wofi
hyprctl keyword layerrule blur, wofi
hyprctl dispatch exec wofi
sleep 1.0
hyprctl keyword layerrule noanim, wofi
