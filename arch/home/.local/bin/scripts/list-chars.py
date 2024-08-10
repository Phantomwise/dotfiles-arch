#!/usr/bin/env python3

# Author : ChatGPT
# Description :
    # Lists all ASCII (0-127) and extended ASCII (128-255) characters

import codecs
import sys
import io

# Set UTF-8 encoding for stdout
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

def print_char(code, encoding='utf-8'):
    try:
        if encoding == 'windows-1252':
            char = chr(code).encode('windows-1252', errors='replace').decode('windows-1252')
        else:
            char = chr(code)
        print(f"{code}: {char}")
    except UnicodeEncodeError:
        # Handle cases where the character cannot be displayed
        print(f"{code}: [Non-displayable character]")

def display_range(start, end, encoding='utf-8'):
    for i in range(start, end + 1):
        print_char(i, encoding)

def display_category(category):
    if category == "Control":
        display_range(0, 31)
    elif category == "Printable (Standard)":
        display_range(32, 126)
    elif category == "DEL":
        print_char(127)
    elif category == "Extended ASCII":
        display_range(128, 255)
    elif category == "ANSI":
        display_range(128, 255, encoding='windows-1252')
    elif category == "All":
        display_range(0, 31)
        display_range(32, 126)
        print_char(127)
        display_range(128, 255)
    else:
        print("Unknown category.")

def main():
    print("Choose a category to display:")
    print("0. All (0-255)")
    print("1. Control (0-31)")
    print("2. Printable (Standard) (32-126)")
    print("3. DEL (127)")
    print("4. Extended ASCII (128-255)")
    print("5. ANSI (Windows-1252) (128-255)")

    choice = input("Enter your choice (0-5): ")

    if choice == "0":
        display_category("All")
    elif choice == "1":
        display_category("Control")
    elif choice == "2":
        display_category("Printable (Standard)")
    elif choice == "3":
        display_category("DEL")
    elif choice == "4":
        display_category("Extended ASCII")
    elif choice == "5":
        display_category("ANSI")
    else:
        print("Invalid choice.")

if __name__ == "__main__":
    main()
