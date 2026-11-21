#!/bin/sh

set -eu

SCREENSHOT_DIR="${XDG_PICTURES_DIR:-"$HOME/Pictures"}/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

"$HOME/.dots/scripts/wayfreeze" --hide-cursor &
WAYFREEZE_PID=$!

trap 'kill "$WAYFREEZE_PID" 2>/dev/null || true' EXIT

sleep 0.1

GEOMETRY="$(slurp)" || exit 0

FILE="$SCREENSHOT_DIR/screenshot-$(date '+%Y-%m-%d_%H-%M-%S').png"

grim -g "$GEOMETRY" "$FILE"
wl-copy --type image/png < "$FILE"

echo "Saved: $FILE"

