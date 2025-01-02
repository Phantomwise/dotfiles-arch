#!/usr/bin/env bash

# Description:
# This script embeds a thumbnail image into a video file (MP4, MKV).

# AI Disclaimer:
# This script was written with help from a LLM.

# Loop through each video file in the current directory
for video in *.mp4 *.mkv; do
  # Check if the video file exists
  [ -e "$video" ] || continue

  # Get the base name of the video file (without extension)
  base_name="${video%.*}"

  # Construct the corresponding thumbnail image file name
  thumbnail="$base_name.jpg"

  # Check if the thumbnail image exists
  if [ -e "$thumbnail" ]; then
    # Determine the output file extension
    extension="${video##*.}"
    output_file="${base_name}_with_thumbnail.${extension}"

    # Use ffmpeg to embed the thumbnail image into the video file
    ffmpeg -i "$video" -i "$thumbnail" -map 0 -map 1 -c copy -disposition:1 attached_pic "$output_file"
  fi
done