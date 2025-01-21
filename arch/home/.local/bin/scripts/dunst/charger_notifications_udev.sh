#!/bin/bash

# Check the argument
if [ "$1" == "connected" ]; then
    charger_status="connected"
    icon="charger-plugged"
    message_id="99114103"
elif [ "$1" == "disconnected" ]; then
    charger_status="disconnected"
    icon="charger-unplugged"
    message_id="99114103"
else
    echo "Invalid argument. Use 'connected' or 'disconnected'."
    exit 1
fi

# Log the event
echo "$(date) $charger_status" >> /tmp/udev-61-charger-rules.log

# Get the user who is currently logged in
user=$(who | awk '{print $1}' | head -n 1)

# Export the DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u $user)/bus"

# Run dunstify as the logged-in user with a specific message ID and icon
su -c "DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dunstify -r '$message_id' -i '$icon' 'Charger' 'Charger $charger_status'" $user