#!/bin/bash

# AI Disclaimer:
# This script was written with help from Github Copilot.

# ANSI escape codes for colors
red='\033[91m'    # Red color for error messages
yellow='\033[93m' # Yellow color for warning messages
green='\033[92m'  # Green color for success messages
reset='\033[0m'   # Reset formatting

# Function to extract video ID from filename
extract_video_id() {
    # Check if the filename contains a YouTube video ID pattern [11 characters]
    if [[ $1 =~ \[([a-zA-Z0-9_-]{11})\] ]]; then
        # If a match is found, print the video ID
        echo "${BASH_REMATCH[1]}"
    else
        # If no match is found, print an empty string
        echo ""
    fi
}

# Function to download thumbnail
download_thumbnail() {
    local video_id=$1  # The video ID extracted from the filename
    local save_path=$2 # The path where the thumbnail will be saved
    # Array of possible thumbnail resolutions
    local resolutions=("maxresdefault.jpg" "hqdefault.jpg" "mqdefault.jpg" "sddefault.jpg" "default.jpg")
    
    # Loop through each resolution to find the highest quality available
    for resolution in "${resolutions[@]}"; do
        # Construct the URL for the thumbnail image
        local url="https://img.youtube.com/vi/${video_id}/${resolution}"
        # Use curl to download the thumbnail and capture the HTTP response code
        local response=$(curl -s -o "$save_path" -w "%{http_code}" "$url")
        
        # Check if the HTTP response code is 200 (OK)
        if [[ $response -eq 200 ]]; then
            # If the thumbnail is found, print a success message and return
            echo -e "${green}Thumbnail downloaded for video ID ${video_id} : ${resolution}${reset}"
            return 0
        else
            # If the thumbnail is not found, print a warning message
            echo -e "${yellow}Thumbnail not found for video ID ${video_id} : ${resolution}${reset}"
        fi
    done
}