#!/bin/bash

CURRENT_HOSTNAME=$(hostname)

if [ "$CURRENT_HOSTNAME" = "linux-kkeeter" ]; then
  monitor=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep HDMI)
  laptop=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep DP)

  if [ -n $monitor ]; then
    xrandr --output "$monitor" --auto --primary
    xrandr --output "$laptop" --off
  fi
fi
