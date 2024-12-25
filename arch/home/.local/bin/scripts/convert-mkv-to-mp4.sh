#!/usr/bin/env bash

for file in *.mkv; do
  ffmpeg -i "$file" "${file%.mkv}.mp4"
done