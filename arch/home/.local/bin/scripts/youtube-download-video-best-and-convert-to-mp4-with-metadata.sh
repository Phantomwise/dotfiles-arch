#!/usr/bin/env bash

# AI Disclaimer:
# This script was written with help from a LLM.

# Description:
# Runs yt-dlp to download the best video format with subtitles, convert them to mp4 and add metadata
# Extracts metadata
# Uses cookies from Firefox to download restricted videos
# Required: yt-dlp

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
    read -p "Do you want to download 1. only the video or 2. the full playlist? (Enter 1 or 2, default is 1): " choice
    choice=${choice:-1}
    if [[ $choice == "1" ]]; then
        echo -e "${info} Downloading only the video."
        url=$(echo "$url" | sed 's/\&list=.*/\&/g')
        # Remove trailing & or ? if they are left at the end
        url=$(echo "$url" | sed 's/[?&]$//')
    else
        echo -e "${info} Downloading the full playlist."
    fi
fi

# Define function to download the best video format with subtitles, using cookies from Firefox for restricted videos
function download_video_w_sub {
    echo -e "${info} Running yt-dlp to download video with subtitles:"
    yt-dlp --cookies-from-browser firefox --write-subs --sub-langs "all" "$url" && \
    echo -e "${succ} Download video with subtitles successful." || \
    { echo -e "${err} Error while downloading video with subtitles."; return 1; }
}

# Define function to convert downloaded video to mp4 using ffmpeg and add metadata
function convert_to_mp4_with_metadata {
    input_file="$1"
    output_file="${input_file%.*}.mp4"
    echo -e "${info} Converting $input_file to $output_file using ffmpeg and adding metadata:"
    title=$(yt-dlp --get-filename -o "%(title)s" "$url")
    artist=$(yt-dlp --get-filename -o "%(uploader)s" "$url")
    date=$(yt-dlp --get-filename -o "%(upload_date)s" "$url")
    description=$(yt-dlp --get-filename -o "%(description)s" "$url")

    if [[ "${input_file##*.}" == "mp4" ]]; then
        original_file="${input_file%.*}-original.mp4"
        cp "$input_file" "$original_file"
        ffmpeg -y -i "$original_file" -c:v copy -c:a copy \
               -metadata title="$title" \
               -metadata artist="$artist" \
               -metadata date="$date" \
               -metadata comment="$description" \
               "$output_file" && \
        echo -e "${succ} Metadata added to mp4 file successfully." || \
        echo -e "${err} Error while adding metadata to mp4 file."
    else
        ffmpeg -i "$input_file" -c:v copy -c:a copy \
               -metadata title="$title" \
               -metadata artist="$artist" \
               -metadata date="$date" \
               -metadata comment="$description" \
               "$output_file" && \
        echo -e "${succ} Conversion to mp4 with metadata successful." || \
        echo -e "${err} Error while converting to mp4 with metadata."
    fi
}

# Run each command in order, continue on failure
download_video_w_sub

# Check if the download was successful before proceeding
if [ $? -eq 0 ]; then
    # Get the exact filename of the downloaded video
    downloaded_file=$(yt-dlp --print filename "$url")
    convert_to_mp4_with_metadata "$downloaded_file"
else
    echo -e "${err} Download failed, skipping conversion."
fi
