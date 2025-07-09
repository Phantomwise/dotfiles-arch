#!/usr/bin/env bash

for file in *.webm; do
  ffmpeg -i "$file" "${file%.webm}.mp4"
done