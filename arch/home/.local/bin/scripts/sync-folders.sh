#!/bin/bash

# AI Disclaimer : This script was written with help from AI tools.

# ANSI escape codes for colors
red='\033[91m'    # Red color for error messages
yellow='\033[93m' # Yellow color for warning messages
green='\033[92m'  # Green color for success messages
reset='\033[0m'   # Reset formatting

# File containing the paths to monitor and sync
DIR_PATH="$HOME/Sync/SynologyDrive/home/Secrets/sync-paths.txt"

# Function to monitor and sync a single source-destination pair
monitor_and_sync() {
    local src=$1
    local dst=$2

    echo -e "Monitoring $src for changes..."
    while inotifywait -r -e modify,create,delete,move "$src"; do
        echo -e "${yellow}Change detected in $src. Syncing to $dst...${reset}"
        rsync -av --delete "$src/" "$dst/"
        echo -e "${green}Sync complete for $src -> $dst.${reset}"
        notify-send "Sync Complete" "Synced $src to $dst"
    done
}

# Parse DIR_PATH
# Read each non-empty, non-comment line
grep -vE '^\s*#|^\s*$' "$DIR_PATH" | while IFS=":" read -r src dst; do
    # Expand variables and remove quotes
    src=$(eval echo "${src//\"/}")
    dst=$(eval echo "${dst//\"/}")

    # List the paths
    echo -e "Source: $src"
    echo -e "Destination: $dst"

    # Perform an initial sync
    echo -e "Performing initial sync for $src -> $dst..."
    rsync -av --delete "$src/" "$dst/"
    echo -e "Initial sync complete for $src -> $dst."

    # Start monitoring and syncing in the background
    monitor_and_sync "$src" "$dst" &
done
