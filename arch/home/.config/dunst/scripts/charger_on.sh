#!/bin/bash

# Send notification
dunstify "Battery Charger Connected" "Laptop is now charging." -u normal -r 99114103 -i battery_plus
# notify-send "Charger connected"

# Log the event
echo "$(date): Charger connected" >> /tmp/charger_log.txt
