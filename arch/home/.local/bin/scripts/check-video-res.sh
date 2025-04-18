#!/bin/bash

# AI Disclaimer:
# This script was written with help from GitHub Copilot.

# Check if ffprobe is installed
if ! command -v ffprobe &> /dev/null; then
    echo "ffprobe is not installed. Please install FFmpeg to use this script."
    exit 1
fi

# Find all video files, sort them, and process them
find . -maxdepth 1 -type f -iname "*.mp4" | sort | while IFS= read -r file; do
    # Get the resolution using ffprobe
    resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0 "$file")
    echo "$resolution,$file"
done | awk -F, '{ printf "%-2s %-5s %s\n", $1, $2, $3 }'