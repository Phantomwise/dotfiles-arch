#!/bin/bash

# AI Disclaimer : This script was written with help from AI tools.

# ANSI escape codes for colors
red='\033[91m'    # Red color for error messages
yellow='\033[93m' # Yellow color for warning messages
green='\033[92m'  # Green color for success messages
reset='\033[0m'   # Reset formatting

# File containing the paths to monitor and sync
DIR_PATH="$HOME/Secrets/sync-paths.txt"

# Function to monitor and sync a single source-destination pair
monitor_and_sync() {
    local src=$1
    local dst=$2

    echo -e "${yellow}Monitoring $src for changes...${reset}"
    while inotifywait -r -e modify,create,delete,move "$src"; do
        echo -e "${yellow}Change detected in $src. Syncing to $dst...${reset}"
        rsync -av --delete-delay "$src/" "$dst/"
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

    # Check if both source and destination are available
    if [ ! -d "$src" ] || ! findmnt -T "$dst" > /dev/null 2>&1; then
        if [ ! -d "$src" ]; then
            echo -e "${red}Source $src is missing. Skipping and retrying later...${reset}"
        fi
        if ! findmnt -T "$dst" > /dev/null 2>&1; then
            echo -e "${red}Destination $dst is not mounted. Skipping and retrying later...${reset}"
        fi

        # Retry in the background
        (
            while [ ! -d "$src" ] || ! findmnt -T "$dst" > /dev/null 2>&1; do
                if [ ! -d "$src" ]; then
                    echo -e "${yellow}Retrying to find source $src in 5 minutes...${reset}"
                fi
                if ! findmnt -T "$dst" > /dev/null 2>&1; then
                    echo -e "${yellow}Retrying to find destination $dst in 5 minutes...${reset}"
                fi
                sleep 300
            done

            echo -e "${green}Both source $src and destination $dst are now available. Continuing...${reset}"

            # Perform an initial sync once both are available
            echo -e "${yellow}Performing initial sync for $src -> $dst...${reset}"
            rsync -av --delete-delay "$src/" "$dst/"
            echo -e "${green}Initial sync complete for $src -> $dst.${reset}"

            # Start monitoring and syncing in the background
            monitor_and_sync "$src" "$dst" &
        ) &
        continue
    fi

    # Perform an initial sync if both paths are available
    echo -e "${yellow}Performing initial sync for $src -> $dst...${reset}"
    rsync -av --delete-delay "$src/" "$dst/"
    echo -e "${green}Initial sync complete for $src -> $dst.${reset}"

    # Start monitoring and syncing in the background
    monitor_and_sync "$src" "$dst" &
done

# Wait for all background processes to finish
wait