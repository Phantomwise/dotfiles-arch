#!/usr/bin/env bash

## Script to find video files with a resolution below, above, or equal to a specified threshold

# Ask for the resolution threshold with an operator
read -p "Enter the resolution threshold (e.g., <1000, =1080, >720, >=1080, <=720): " input

# Extract the operator and the threshold value
operator=$(echo "$input" | grep -o '^[<>]=\|^[<>=]')
threshold=$(echo "$input" | grep -o '[0-9]*$')

# Validate the operator
if [[ "$operator" != "<" && "$operator" != ">" && "$operator" != "=" && "$operator" != "<=" && "$operator" != ">=" ]]; then
    echo "Invalid operator. Please use one of the following: <, >, =, <=, >="
    exit 1
fi

# Validate the threshold
if ! [[ "$threshold" =~ ^[0-9]+$ ]]; then
    echo "Invalid threshold. Please enter a valid number."
    exit 1
fi

# Find all video files in the collection
find . -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \) | while read -r file; do
    # Get the resolution of the video file
    resolution=$(ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0:s=x "$file")
    width=$(echo $resolution | cut -d'x' -f1)
    
    # Compare the width with the threshold using the operator
    if [ "$(echo "$width $operator $threshold" | bc)" -eq 1 ]; then
        echo -e "\e[33m$resolution\e[0m $file"
    fi
done