#!/bin/bash

# Check for updates
updates=$(checkupdates 2> /dev/null | wc -l)

# If there are updates, send a notification
if [ "$updates" -gt 0 ]; then
    dunstify "System Updates" "There are $updates updates available."
fi