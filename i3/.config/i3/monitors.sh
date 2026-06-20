#!/bin/bash

CURRENT_HOSTNAME=$(hostname)

if [ "$CURRENT_HOSTNAME" = "linux-kkeeter" ]; then
  # Get internal laptop display (typically eDP-* or LVDS*)
  laptop=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep -E "^(eDP|LVDS)")
  # Get external monitor (any connected display that's not the internal one)
  monitor=$(xrandr -q | grep " connected" | cut -d" " -f1 | grep -vE "^(eDP|LVDS)" | head -n1)

  if [ -n "$monitor" ]; then
    # Lock the ultrawide to its native mode (square pixels, max real density).
    # Avoids drifting to the 3840x2160 16:9 mode, which the 21:9 panel downscales.
    # Falls back to --auto if this exact mode isn't offered (e.g. a different display).
    if ! xrandr --output "$monitor" --mode 3440x1440 --rate 84.96 --primary 2>/dev/null; then
      xrandr --output "$monitor" --auto --primary
    fi
    xrandr --output "$laptop" --off
  fi
elif [ "$CURRENT_HOSTNAME" = "kirk-papigrande" ]; then
  # Desktop: single monitor, set as primary for polybar main bar
  monitor=$(xrandr -q | grep " connected" | head -n1 | cut -d" " -f1)
  if [ -n "$monitor" ]; then
    xrandr --output "$monitor" --primary
  fi
fi

~/.config/polybar/launch.sh
