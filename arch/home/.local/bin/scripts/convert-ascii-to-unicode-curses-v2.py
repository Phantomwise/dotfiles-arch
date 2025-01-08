#!/usr/bin/env python3

import os
import curses
import subprocess
import json

# Determine the directory of the script
script_dir = os.path.dirname(os.path.realpath(__file__))
json_file_path = os.path.join(script_dir, 'convert-ascii-to-unicode-curses-v2.json')

# Load the JSON file
with open(json_file_path, 'r') as file:
    data = json.load(file)

# Create a dictionary to map ASCII characters to their Unicode equivalents for each style
styles = {}
for style in data['styles']:
    styles[style['name']] = {
        'name2': style.get('name2', style['name']),
        'uppercase': dict(zip(data['characters']['uppercase'], style.get('uppercase', ''))),
        'lowercase': dict(zip(data['characters']['lowercase'], style.get('lowercase', ''))),
        'numbers': dict(zip(data['characters']['numbers'], style.get('numbers', '')))
    }

# Function to convert text to a specific style
def convert_to_style(text, style_name):
    if style_name not in styles:
        raise ValueError(f"Style '{style_name}' not found")
    styled_text = []
    for char in text:
        if char in styles[style_name]['uppercase']:
            styled_text.append(styles[style_name]['uppercase'][char])
        elif char in styles[style_name]['lowercase']:
            styled_text.append(styles[style_name]['lowercase'][char])
        elif char in styles[style_name]['numbers']:
            styled_text.append(styles[style_name]['numbers'][char])
        else:
            styled_text.append(char)
    return ''.join(styled_text)

# Function to copy text to clipboard
def copy_to_clipboard(text):
    session_type = os.environ.get('XDG_SESSION_TYPE')
    if session_type == 'wayland':
        subprocess.run(['wl-copy'], input=text.encode('utf-8'))
    elif session_type == 'x11':
        subprocess.run(['xclip', '-selection', 'clipboard'], input=text.encode('utf-8'))
    else:
        raise EnvironmentError("Unsupported or unknown XDG_SESSION_TYPE: {}".format(session_type))

# Main function for the TUI
def main(stdscr, input_text):
    curses.curs_set(0)  # Hide the cursor
    stdscr.clear()
    stdscr.refresh()

    styles_list = list(styles.keys())
    current_selection = 0
    start_index = 0

    while True:
        stdscr.clear()
        h, w = stdscr.getmaxyx()

        max_visible_items = h // 3  # Each item takes 3 lines
        end_index = start_index + max_visible_items

        for idx, style in enumerate(styles_list[start_index:end_index]):
            style_display_name = styles[style]['name2']
            item_width = len(style_display_name) + 4  # Adding space for borders
            item_height = 3  # 1 line for text, 2 lines for top and bottom borders
            x = w // 2 - item_width // 2
            y = idx * item_height

            # Draw border
            stdscr.addch(y, x, curses.ACS_ULCORNER)
            stdscr.addch(y, x + item_width - 1, curses.ACS_URCORNER)
            stdscr.addch(y + item_height - 1, x, curses.ACS_LLCORNER)
            stdscr.addch(y + item_height - 1, x + item_width - 1, curses.ACS_LRCORNER)
            for i in range(1, item_width - 1):
                stdscr.addch(y, x + i, curses.ACS_HLINE)
                stdscr.addch(y + item_height - 1, x + i, curses.ACS_HLINE)
            for i in range(1, item_height - 1):
                stdscr.addch(y + i, x, curses.ACS_VLINE)
                stdscr.addch(y + i, x + item_width - 1, curses.ACS_VLINE)

            # Draw text
            text_x = x + (item_width - len(style_display_name)) // 2
            if idx + start_index == current_selection:
                stdscr.attron(curses.A_REVERSE)
                stdscr.addstr(y + 1, text_x, style_display_name)
                stdscr.attroff(curses.A_REVERSE)
            else:
                stdscr.addstr(y + 1, text_x, style_display_name)

        key = stdscr.getch()

        if key == curses.KEY_UP and current_selection > 0:
            current_selection -= 1
            if current_selection < start_index:
                start_index -= 1
        elif key == curses.KEY_DOWN and current_selection < len(styles_list) - 1:
            current_selection += 1
            if current_selection >= end_index:
                start_index += 1
        elif key == curses.KEY_ENTER or key in [10, 13]:
            break

    selected_style = styles_list[current_selection]
    converted_text = convert_to_style(input_text, selected_style)
    stdscr.clear()
    stdscr.addstr(0, 0, f"Input text: {input_text}")
    stdscr.addstr(1, 0, f"Selected style: {styles[selected_style]['name2']}")
    stdscr.addstr(2, 0, f"Converted text: {converted_text}")
    stdscr.refresh()
    stdscr.getch()

    # Copy the converted text to the clipboard
    copy_to_clipboard(converted_text)

if __name__ == "__main__":
    input_text = input("Enter the text to convert: ")
    curses.wrapper(main, input_text)