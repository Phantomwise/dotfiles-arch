#!/bin/bash

# Send notification
dunstify "Battery Charger Disconnected" "Laptop is no longer charging." -u normal -r 99114103 -i battery_minus
# notify-send "Charger disconnected"

# Log the event
echo "$(date): Charger disconnected" >> /tmp/charger_log.txt
