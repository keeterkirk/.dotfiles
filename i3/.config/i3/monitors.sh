#!/bin/bash

CURRENT_HOSTNAME=$(hostname)

if [ "$CURRENT_HOSTNAME" = "linux-kkeeter" ]; then
  monitor=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep HDMI)
  laptop=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep eDP)

  if [ -n "$monitor" ]; then
    xrandr --output "$laptop" --left-of "$monitor" --auto
    xrandr --output "$monitor" --right-of "$laptop" --auto --primary
  fi
fi
