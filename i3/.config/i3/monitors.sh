#!/bin/bash

CURRENT_HOSTNAME=$(hostname)

if [ "$CURRENT_HOSTNAME" = "linux-kkeeter" ]; then
  # Get internal laptop display (typically eDP-* or LVDS*)
  laptop=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep -E "^(eDP|LVDS)")
  # Get external monitor (any connected display that's not the internal one)
  monitor=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep -vE "^(eDP|LVDS)" | head -n1)

  if [ -n "$monitor" ]; then
    xrandr --output "$monitor" --auto --primary
    xrandr --output "$laptop" --off
  fi
fi

~/.config/polybar/launch.sh
