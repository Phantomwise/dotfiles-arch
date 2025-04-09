#!/bin/bash

# AI Disclaimer:
# This script was written with help from GitHub Copilot.

# Function to determine the correct image type
get_image_type() {
  local file_path="$1"
  file_type=$(file --mime-type -b "$file_path")
  
  case "$file_type" in
    image/jpeg) echo "jpg" ;;
    image/png) echo "png" ;;
    image/gif) echo "gif" ;;
    image/bmp) echo "bmp" ;;
    image/webp) echo "webp" ;;
    image/tiff) echo "tiff" ;;
    *) echo "unknown" ;;
  esac
}

# Function to find a unique filename
find_unique_name() {
  local base_name="$1"
  local extension="$2"
  local counter=1
  local new_name="${base_name}.${extension}"

  while [[ -e "$new_name" ]]; do
    new_name="${base_name}-${counter}.${extension}"
    ((counter++))
  done

  echo "$new_name"
}

# Process all files recursively
find . -type f | while read -r file; do
  # Skip non-image files
  correct_extension=$(get_image_type "$file")
  if [[ "$correct_extension" == "unknown" ]]; then
    continue
  fi

  # Extract filename and current extension
  dir=$(dirname "$file")
  base_name=$(basename "$file")
  current_extension="${base_name##*.}"
  base_name="${base_name%.*}"

  # If the file has no extension or the wrong extension
  if [[ "$current_extension" != "$correct_extension" ]]; then
    if [[ "$current_extension" == "$base_name" ]]; then
      # No extension case
      new_name=$(find_unique_name "$dir/$base_name" "$correct_extension")
    else
      # Wrong extension case
      new_name=$(find_unique_name "$dir/$base_name" "$correct_extension")
    fi

    # Rename the file
    mv "$file" "$new_name"
    echo "Renamed: $file -> $new_name"
  fi
done