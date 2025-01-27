#!/bin/bash

logfile="/tmp/charger_notifications_udev.log"
lockfile="/tmp/charger_notifications_udev.lock"
statefile="/tmp/charger_state"

# Use flock to create a lock and ensure only one instance runs
{
    flock -n 9 || exit 1

    # Check the argument
    if [ "$1" == "connected" ]; then
        charger_status="connected"
        category="charger.connected"
        # icon="charger-connected"
        message_id="99114103"
    elif [ "$1" == "disconnected" ]; then
        charger_status="disconnected"
        category="charger.disconnected"
        # icon="charger-disconnected"
        message_id="99114103"
    else
        echo "Invalid argument. Use 'connected' or 'disconnected'."
        exit 1
    fi

    # Read the last state
    if [ -f "$statefile" ]; then
        last_status=$(cat "$statefile")
    else
        last_status=""
    fi

    # Only proceed if the state has changed
    if [ "$charger_status" != "$last_status" ]; then
        # Log the event
        echo "$(date) $charger_status" >> $logfile

        # Get the user who is currently logged in
        user=$(who | awk '{print $1}' | head -n 1)

        # Export the DBUS_SESSION_BUS_ADDRESS
        export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $user)/bus"

        # Run dunstify as the logged-in user with a specific message ID and icon
        su -c "DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dunstify -r '$message_id' 'Charger' 'Charger $charger_status' -h 'string:category:$category'" $user

        # Update the state file
        echo "$charger_status" > "$statefile"
    fi

    # Add a small delay to prevent race conditions
    sleep 2

} 9>"$lockfile"