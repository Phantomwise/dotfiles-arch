#!/bin/bash

# AI Disclaimer:
# This script was written with help from GitHub Copilot.

function convert_to_mp4_with_metadata {
    input_file="$1"
    youtube_id=$(echo "$input_file" | grep -oP '\[([^\]]+)\](?=[^\[]*$)' | tr -d '[]')
    output_file="${input_file%.*}.mp4"

    if [[ -n "$youtube_id" ]]; then
        title=$(yt-dlp --cookies-from-browser firefox --get-filename -o "%(title)s" "https://www.youtube.com/watch?v=$youtube_id")
        artist=$(yt-dlp --cookies-from-browser firefox --get-filename -o "%(uploader)s" "https://www.youtube.com/watch?v=$youtube_id")
        description=$(yt-dlp --cookies-from-browser firefox --get-filename -o "%(description)s" "https://www.youtube.com/watch?v=$youtube_id")
        date=$(yt-dlp --cookies-from-browser firefox --get-filename -o "%(upload_date)s" "https://www.youtube.com/watch?v=$youtube_id")

        echo -e "Converting $input_file to $output_file with metadata."

        if [[ "$input_file" == *.mp4 ]]; then
            new_output_file="${input_file%.*}-new.mp4"
            original_file="${input_file%.*}-original.mp4"
            mv "$input_file" "$original_file"
            ffmpeg -i "$original_file" -c:v copy -c:a copy \
                -metadata title="$title" \
                -metadata artist="$artist" \
                -metadata description="$description" \
                -metadata date="$date" \
                "$new_output_file" && \
            echo -e "Conversion to MP4 with metadata successful." || \
            { echo -e "Error during conversion to MP4 with metadata."; return 1; }
        else
            ffmpeg -i "$input_file" -c:v copy -c:a copy \
                -metadata title="$title" \
                -metadata artist="$artist" \
                -metadata description="$description" \
                -metadata date="$date" \
                "$output_file" && \
            echo -e "Conversion to MP4 with metadata successful." || \
            { echo -e "Error during conversion to MP4 with metadata."; return 1; }
        fi
    else
        echo -e "Could not extract YouTube ID from filename $input_file."
        return 1
    fi
}

# Process all video files in the current working directory
for input_file in *.mkv *.webm *.flv *.avi *.mov *.wmv *.mp4; do
    if [[ -f "$input_file" ]]; then
        convert_to_mp4_with_metadata "$input_file"
    fi
done