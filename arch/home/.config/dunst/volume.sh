#!/bin/sh

# Define the path to your icons
ICON_PATH="$HOME/.local/share/icons/svg"

# Perform the volume change or mute toggle
case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume -l 2.0 @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

# Retrieve the volume and mute status
STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOLUME=$(echo "$STATUS" | grep -oP '\d+\.\d+')
MUTE=$(echo "$STATUS" | grep -q 'MUTED' && echo 'MUTED')

send_notification() {
    if [ "$MUTE" = "MUTED" ]; then
        ICON="mute"
        TEXT="Currently muted"
        PERCENT=0
    else
        if [ "$(echo "$VOLUME < 0.50" | bc -l)" -eq 1 ]; then
            ICON="low"
        elif [ "$(echo "$VOLUME < 1" | bc -l)" -eq 1 ]; then
            ICON="medium"
        else
            ICON="high"
        fi
        PERCENT=$(echo "$VOLUME * 100" | bc -l | xargs printf "%.0f")
        TEXT="Currently at ${PERCENT}%"
    fi

    dunstify -a "Volume" -r 9993 -h int:value:"$PERCENT" -i "$ICON_PATH/volume-$ICON.svg" "Volume" "$TEXT" -t 2000
}

send_notification
