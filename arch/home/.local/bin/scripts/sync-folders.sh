#!/bin/bash

# AI Disclaimer : This script was written with help from AI tools.

# File containing the paths to monitor and sync
DIR_PATH="$HOME/Sync/SynologyDrive/home/Secrets/sync-paths.txt"

# Function to monitor and sync a single source-destination pair
monitor_and_sync() {
    local src=$1
    local dst=$2

    echo -e "Monitoring $src for changes..."
    while inotifywait -r -e modify,create,delete,move "$src"; do
        echo -e "Change detected in $src. Syncing to $dst..."
        rsync -av --delete "$src/" "$dst/"
        echo -e "Sync complete for $src -> $dst."
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
