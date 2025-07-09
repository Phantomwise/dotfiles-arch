#!/bin/bash

# AI Disclaimer:
# This script was written with help from a LLM.

logfile="/tmp/usb_notifications_udev.log"
lockfile="/tmp/usb_notifications_udev.lock"
state_dir="/tmp/usb_states"
type_dir="/tmp/usb_types"

# Ensure the state and type directories exist
mkdir -p "$state_dir"
mkdir -p "$type_dir"

# Use flock to create a lock and ensure only one instance runs
{
    flock -n 9 || exit 1

    # Check the argument
    if [ "$1" == "connected" ]; then
        device_status="connected"
        category="usb.connected"
        message_id="117115066"
    elif [ "$1" == "disconnected" ]; then
        device_status="disconnected"
        category="usb.disconnected"
        message_id="117115066"
    else
        echo "Invalid argument. Use 'connected' or 'disconnected'."
        exit 1
    fi

    # Get the device path from the environment variable
    device_path="$DEVPATH"
    shortened_device_path=$(echo "$device_path" | sed 's|.*/\(usb.*\)|\1|')
    statefile="$state_dir/$(basename $device_path)"
    typefile="$type_dir/$(basename $device_path)"

    if [ "$device_status" == "connected" ]; then
        # Determine the device type and vendor using udevadm
        device_model=$(udevadm info --query=property --path=$device_path | grep ID_MODEL_FROM_DATABASE | cut -d'=' -f2 | head -n 1)
        if [ -z "$device_model" ]; then
            device_model=$(udevadm info --query=property --path=$device_path | grep ID_MODEL | cut -d'=' -f2 | head -n 1)
        fi
        device_vendor=$(udevadm info --query=property --path=$device_path | grep ID_VENDOR_FROM_DATABASE | cut -d'=' -f2 | head -n 1)
        if [ -z "$device_vendor" ]; then
            device_vendor=$(udevadm info --query=property --path=$device_path | grep ID_VENDOR | cut -d'=' -f2 | head -n 1)
        fi
        device_type="${device_model:-Unknown Device}"
        device_vendor="${device_vendor:-Unknown Vendor}"

        # Save the device type and vendor to a file
        echo "$device_type" > "$typefile"
        echo "$device_vendor" >> "$typefile"
    elif [ "$device_status" == "disconnected" ]; then
        # Read the device type and vendor from the file
        if [ -f "$typefile" ]; then
            device_type=$(sed -n '1p' "$typefile")
            device_vendor=$(sed -n '2p' "$typefile")
            # Remove the type file after reading
            rm -f "$typefile"
        else
            device_type="Unknown Device"
            device_vendor="Unknown Vendor"
        fi
    fi

    # Read the last state
    if [ -f "$statefile" ]; then
        last_status=$(cat "$statefile")
    else
        last_status=""
    fi

    # Only proceed if the state has changed
    if [ "$device_status" != "$last_status" ]; then
        # Log the event
        echo "$(date) $device_status $device_path $device_type $device_vendor" >> $logfile

        # Get the user who is currently logged in
        user=$(who | awk '{print $1}' | head -n 1)

        # Export the DBUS_SESSION_BUS_ADDRESS
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $user)/bus"

        # Run dunstify as the logged-in user with a specific message ID and icon
        su -c "DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dunstify -r '$message_id' 'USB Device' '$device_type by $device_vendor $device_status at $shortened_device_path' -h 'string:category:$category'" $user

        # Update the state file
        echo "$device_status" > "$statefile"
    fi

    # Add a small delay to prevent race conditions
    sleep 1

} 9>"$lockfile"
