#!/usr/bin/env bash

# AI Disclaimer:
# This script was written with help from a LLM.

# Description :
    # Lists all ASCII (0-127) and extended ASCII (128-255) characters

# Function to print a character with its ASCII code
print_char() {
    local code=$1
    printf "%d: %b\n" "$code" "$(printf "\\x$(printf %x $code)")"
}

# Function to display characters in a specific range
display_range() {
    local start=$1
    local end=$2
    for i in $(seq $start $end); do
        print_char $i
    done
}

# Function to display characters based on category
display_category() {
    local category=$1
    case $category in
        "Control")
            display_range 0 31
            ;;
        "Printable (Standard)")
            display_range 32 126
            ;;
        "DEL")
            print_char 127
            ;;
        "Extended ASCII")
            display_range 128 255
            ;;
        "All")
            display_range 0 31
            display_range 32 126
            print_char 127
            display_range 128 255
            ;;
        *)
            echo "Unknown category."
            ;;
    esac
}

# Main script
echo "Choose a category to display:"
echo "0. All (0-255)"
echo "1. Control (0-31)"
echo "2. Printable (Standard) (32-126)"
echo "3. DEL (127)"
echo "4. Extended ASCII (128-255)"

read -p "Enter your choice (0-4): " choice

case $choice in
    0)
        display_category "All"
        ;;
    1)
        display_category "Control"
        ;;
    2)
        display_category "Printable (Standard)"
        ;;
    3)
        display_category "DEL"
        ;;
    4)
        display_category "Extended ASCII"
        ;;
    *)
        echo "Invalid choice."
        ;;
esac
