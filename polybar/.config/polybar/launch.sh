#!/bin/bash

# Serialize invocations so two near-simultaneous calls (e.g. i3 autostart +
# monitors.sh) can't race past the kill/wait and stack duplicate bars.
exec 9>/tmp/polybar-launch.lock
flock 9

# Terminate already running bar instances and wait for them to fully exit
killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done

if type "xrandr" >/dev/null; then
  # Only iterate ACTIVE (powered) outputs. --listactivemonitors skips
  # connected-but-off displays (e.g. the laptop eDP when external is primary),
  # which otherwise spawned a dead "side" bar. The primary is marked with '*'.
  # 9>&- closes the inherited lock fd in each bar; otherwise the backgrounded
  # polybar processes hold the flock for their whole lifetime and deadlock the
  # next launch.
  while read -r marker name; do
    if [[ "$marker" == *"*"* ]]; then
      MONITOR="$name" polybar --reload main 9>&- &
    else
      MONITOR="$name" polybar --reload side 9>&- &
    fi
  done < <(xrandr --listactivemonitors | awk 'NR>1 {print $2, $NF}')
fi

echo "Bars launched..."
