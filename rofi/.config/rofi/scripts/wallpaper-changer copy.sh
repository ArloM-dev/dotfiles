#!/usr/bin/env bash

WALL_DIR="$HOME/Pictures/Wallpapers"

SELECTED_WALL=$(find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) -exec basename {} \; | rofi -dmenu -p "   Wallpapers")

if [ -n "$SELECTED_WALL" ]; then
    awww img "$WALL_DIR/$SELECTED_WALL" --transition-type random
    iris "$WALL_DIR/$SELECTED_WALL" --dark 1
    hyprctl reload
    kill -SIGUSR1 $(pgrep kitty)
fi