#!/usr/bin/env bash

# Path to the sound file
SOUND_FILE="/usr/share/sounds/phantomwise/mixkit-threatening-orchestra-trumpets-2284.wav"

# Play the sound with pw-play (pipewire)
pw-play "$SOUND_FILE"
