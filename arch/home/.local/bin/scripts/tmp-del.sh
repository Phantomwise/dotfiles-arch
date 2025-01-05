#!/usr/bin/env bash

# AI Disclaimer:
# This script was written with help from a LLM.

# Color codes
red='\033[0;31m'
yellow='\033[0;33m'
green='\033[0;32m'
nc='\033[0m' # No Color

# List of folders to clear
folders=(
    "$HOME/.local/share/Trash/" # Trash folder
    "$HOME/.cache/aura/" # Aura cache
    "$HOME/.cache/calibre/" # Calibre cache
    "$HOME/.cache/Google/" # Google cache
    "$HOME/.cache/thumbnails/" # Thumbnail cache
    # "$HOME/.cache/mozilla/firefox/" # Firefox cache
    "$HOME/.cache/paru/clone/" # Paru cache
    # "$HOME/.cache/waterfox/" # Waterfox cache
    "$HOME/.cache/winetricks/" # Winetricks cache
    "$HOME/.cache/yay/" # Yay cache
    "/var/cache/pacman/pkg/" # Pacman cache
    # "/tmp" # Temporary files
    # "/var/log/"
)

# Clear the folders
for folder in "${folders[@]}"; do
    if [ -d "$folder" ]; then
        echo -e "${yellow}Clearing $folder${nc}"
        rm -rf "${folder:?}"/*
        echo -e "${green}Cleared $folder${nc}"
    else
        echo -e "${red}$folder does not exist${nc}"
    fi
done