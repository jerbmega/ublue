#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  MONITOR=$(xrandr --query | grep "primary" | cut -d" " -f1) polybar --reload bar_primary &

  for m in $(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bar_secondary &
  done
else
  polybar --reload bar_primary &
fi
