#!/bin/bash

CURRENT_HOSTNAME=$(hostname)

if [ "$CURRENT_HOSTNAME" = "linux-kkeeter" ]; then
  monitor=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep HDMI)
  laptop=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep DP)

  if [ -n "$laptop" ]; then
    xrandr --output "$laptop" --auto --primary
    xrandr --output "$monitor" --off
  fi
fi

~/.config/polybar/launch.sh
