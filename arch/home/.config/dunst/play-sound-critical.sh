#!/bin/bash

# Path to the sound file
SOUND_FILE="/home/phantomwise/.local/share/sounds/wav/orchestral/mixkit-threatening-orchestra-trumpets-2284.wav"

# Play the sound with pw-play (pipewire)
pw-play "$SOUND_FILE"
