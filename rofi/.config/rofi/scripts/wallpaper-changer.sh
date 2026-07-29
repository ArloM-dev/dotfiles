#!/usr/bin/env bash

WALL_ROOT="$HOME/Pictures/Wallpapers"
CACHE="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$CACHE"

# Pick a directory
DIR=$(find "$WALL_ROOT" -mindepth 1 -type d | sed "s|$WALL_ROOT/||" | \
    rofi -dmenu -p "Folder")

[ -z "$DIR" ] && exit

FULL_DIR="$WALL_ROOT/$DIR"

# Build wallpaper list with thumbnails
entries=()

while IFS= read -r img; do
    name=$(basename "$img")

    hash=$(printf '%s' "$img" | md5sum | cut -d' ' -f1)
    thumb="$CACHE/$hash.png"

    if [ ! -f "$thumb" ]; then
        magick "$img" \
            -thumbnail 400x250^ \
            -gravity center \
            -extent 400x250 \
            "$thumb"
    fi

    entries+=("$name\0icon\x1f$thumb")
done < <(
    find "$FULL_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) |
    sort
)

selected=$(printf '%b\n' "${entries[@]}" | \
    rofi \
    -dmenu \
    -show-icons \
    -p "$DIR" \
    -theme-str '
        window {
            width: 900px;
            height: 700px;
        }

        mainbox {
            children: [ inputbar, message, listview ];
        }

        listview {
            columns: 2;
            lines: 3;
            spacing: 20px;
            fixed-height: false;
        }

        element {
            orientation: vertical;
            padding: 10px;
            spacing: 8px;
        }

        element-icon {
            size: 220px;
        }

        element-text {
            horizontal-align: 0.5;
            vertical-align: 0.5;
            padding: 5px;
        }

        textbox-prompt-colon {
            expand: false;
        }
    ')

[ -z "$selected" ] && exit

wall="$FULL_DIR/$selected"

awww img "$wall" --transition-type random
iris "$wall" --dark 1
hyprctl reload
kill -SIGUSR1 $(pgrep kitty)
echo "\$wall = $wall" > ~/.cache/iris/wallpapers.conf