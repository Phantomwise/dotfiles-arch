#!/usr/bin/env bash

# Color codes
red='\033[0;31m'
yellow='\033[0;33m'
green='\033[0;32m'
nc='\033[0m' # No Color

# List of folders to check
folders=(
    "$HOME/.local/share/Trash/" # Trash folder
    "$HOME/.cache/" # Cache
    "$HOME/.cache/paru/clone/" # Paru cache
    "$HOME/.cache/yay/" # Yay cache
    "$HOME/.cache/mozilla/firefox/" # Firefox cache
    "/var/cache/pacman/pkg/" # Pacman cache
    "/tmp" # Temporary files
    # "/var/log/"
    "$HOME/.cache/thumbnails/"
)

# Calculate the maximum length of folder paths
max_length=0
for folder in "${folders[@]}"; do
    if [ ${#folder} -gt $max_length ]; then
        max_length=${#folder}
    fi
done

# Function to get the color based on the unit
get_color() {
    local size=$1
    if [[ $size == *G ]]; then
        echo -e "${red}$size${nc}"
    elif [[ $size == *M ]]; then
        echo -e "${yellow}$size${nc}"
    elif [[ $size == *K ]]; then
        echo -e "${green}$size${nc}"
    else
        echo -e "${green}$size${nc}"
    fi
}

# Loop through each folder and print its size
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        size=$(du -sh "$folder" 2>/dev/null | cut -f1)
        color_size=$(get_color "$size")
        printf "%-${max_length}s : %s\n" "$folder" "$color_size"
    else
        printf "%-${max_length}s : Folder does not exist.\n" "$folder"
    fi
done