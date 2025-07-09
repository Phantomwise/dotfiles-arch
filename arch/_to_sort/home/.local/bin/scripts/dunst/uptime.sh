#!/bin/bash

# Get uptime
uptime_info=$(uptime -p | sed 's/up //')

# Check if uptime exceeds 1 week
if uptime -p | grep -q "week"; then
    dunstify "Uptime Alert" "Your system has been running for $uptime_info! Please reboot!" -u normal -r 117112116 -h "string:category:uptime"
else
    dunstify "Uptime" "Your system has been running for $uptime_info." -u normal -r 117112116 -h "string:category:uptime"
fi
