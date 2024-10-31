#!/usr/bin/env bash
# Get the geometry of the focused window
geometry=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')

# Get the class of the focused window
window_class=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused).app_id')

# Take the screenshot with the window class in the filename
grim -t png -g "$geometry" "$(xdg-user-dir PICTURES)/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S')_${window_class}.png"