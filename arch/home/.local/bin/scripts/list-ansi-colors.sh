#!/usr/bin/env bash

# Author : ChatGPT
# Description :
    # Lists colors available with ANSI escape codes.
    # Loops through color codes from 0 to 255 and prints a sample text in each color.

    for code in {0..255}
        do echo -e "\e[38;5;${code}m"'\\e[38;5;'"$code"m"\e[0m"
    done
