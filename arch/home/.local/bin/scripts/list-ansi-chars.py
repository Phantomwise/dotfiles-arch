#!/usr/bin/env python3

import sys
import io

# Set UTF-8 encoding for stdout
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def print_char(code):
    try:
        # Encode character in Windows-1252, then decode to UTF-8
        char = bytes([code]).decode('windows-1252')
        print(f"{code}: {char}")
    except UnicodeDecodeError:
        # Handle cases where the character cannot be displayed
        print(f"{code}: [Non-displayable character]")

def display_range(start, end):
    for i in range(start, end + 1):
        print_char(i)

def main():
    print("Displaying ANSI characters (Windows-1252) from 128-255:")
    display_range(128, 255)

if __name__ == "__main__":
    main()
