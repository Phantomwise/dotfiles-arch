#!/bin/sh

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

WARNING_LEVEL=15
CRITICAL_LEVEL=5

# Extract battery status
BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

FULL_FILE=/tmp/batteryfull
EMPTY_FILE=/tmp/batteryempty
CRITICAL_FILE=/tmp/batterycritical

# Remove existing notifications if battery is charging
if [ "$BATTERY_DISCHARGING" -eq 0 ] && [ -f $FULL_FILE ]; then
    rm $FULL_FILE
elif [ "$BATTERY_DISCHARGING" -eq 1 ] && [ -f $EMPTY_FILE ]; then
    rm $EMPTY_FILE
fi

# Check battery levels and send notifications
if [ -n "$BATTERY_LEVEL" ]; then
    if [ "$BATTERY_LEVEL" -gt 99 ] && [ "$BATTERY_DISCHARGING" -eq 0 ] && [ ! -f $FULL_FILE ]; then
        notify-send "Battery Charged" "Battery is fully charged." -u normal -i "battery-v-100" -r 9991
        touch $FULL_FILE
    elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $EMPTY_FILE ]; then
        notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u normal -i "battery-v-alert" -r 9991
        touch $EMPTY_FILE
    elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] && [ ! -f $CRITICAL_FILE ]; then
        notify-send "Battery Critical" "The computer will shutdown soon." -u critical -i "battery-v-alert" -r 9991
        touch $CRITICAL_FILE
    fi
fi
