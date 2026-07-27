#!/usr/bin/env bash

WALL_ROOT="$HOME/Pictures/Wallpapers"
CACHE="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$CACHE"

find "$WALL_ROOT" -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
while read -r img; do
    hash=$(echo "$img" | md5sum | cut -d' ' -f1)
    thumb="$CACHE/$hash.png"

    [ -f "$thumb" ] && continue
    echo "$img"
    magick "$img" \
        -thumbnail 256x256^ \
        -gravity center \
        -extent 256x256 \
        "$thumb"
done