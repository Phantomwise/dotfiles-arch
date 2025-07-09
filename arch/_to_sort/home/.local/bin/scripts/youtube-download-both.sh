#!/usr/bin/env bash

# AI Disclaimer:
# This script was written with help from a LLM.

# Description :
    # Runs yt-dlp to download MP3, OPUS and WEBM
    # Can download a single video or playlist
# Dependencies : yt-dlp

# Define global variables for colored messages
info="\033[1;33m[INFO]\033[0m"
succ="\033[1;32m[SUCCESS]\033[0m"
err="\033[1;31m[ERROR]\033[0m"

# Ask user for input using readline for better handling of interactive input
read -e -p "Enter YouTube URL or ID: " input

# Function to check if the URL is a playlist
function is_playlist {
    if [[ $1 == *"list="* ]]; then
        return 0
    else
        return 1
    fi
}

# Check if the input is a URL or an ID
if [[ $input == *"youtube.com"* ]] || [[ $input == *"youtu.be"* ]]; then
    url="$input"
else
    url="https://www.youtube.com/watch?v=$input"
fi

# If the URL is a playlist, prompt the user to choose whether to download only the video or the full playlist
if is_playlist "$url"; then
    echo -e "${info} This URL links to a playlist."
    read -p "Do you want to download 1. only the video or 2. the full playlist? (Enter 1 or 2): " choice
    if [[ $choice == "1" ]]; then
        url=$(echo "$url" | sed 's/\&list=.*/\&/g')
        # Remove trailing & or ? if they are left at the end
        url=$(echo "$url" | sed 's/[?&]$//')
    fi
fi

# Define function to download the best audio format
function download_audio {
    echo -e "${info} Running yt-dlp to download the best audio format:"
    yt-dlp -x "$url" && \
    echo -e "${succ} Download audio successful." || \
    echo -e "${err} Error while downloading audio."
}

function download_video_w_sub {
    echo -e "${info} Running yt-dlp to download video with subtitles:"
    yt-dlp --write-subs --sub-langs "all" "$url" && \
    echo -e "${succ} Download video with subtitles successful." || \
    echo -e "${err} Error while downloading video with subtitles."
}

# Run each command in order, continue on failure
download_audio
download_video_w_sub