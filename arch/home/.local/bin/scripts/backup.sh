#!/usr/bin/env bash

# Author : ChatGPT
# Description :
    # Creates a timestamped backup of a specified file or folder into ${HOME}/backup while preserving the folder stucture.

# Function to display error messages
display_error() {
    echo "Error: $1"
    exit 1
}

# Function to append timestamp to filename
append_timestamp() {
    local filename="$1"
    local timestamp="$(date +'%Y-%m-%d_%H-%M')"
    echo "${filename}.backup_${timestamp}"
}

# Function to copy file or folder
copy_file_or_folder() {
    local source="$1"
    local destination="$2"
    
    # Check if source exists
    if [ ! -e "$source" ]; then
        display_error "Source file or folder does not exist."
    fi

    # Append timestamp to destination filename
    local timestamp="$(date +'%Y-%m-%d_%H-%M')"
    local dirname="$(dirname "$destination")"
    local filename="$(basename "$destination")"
    local backup_dir="${HOME}/backup${dirname}"
    local timestamped_destination="${backup_dir}/${filename}.backup_${timestamp}"

    # Create the backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    # Copy file or folder
    cp -r "$source" "$timestamped_destination"

    echo "Backup created: $timestamped_destination"
}

# Function to provide bash-completions for file paths
complete_path() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    COMPREPLY=( $(compgen -A file -- "$cur") )
}

# Function to convert file:// URI to local path
convert_uri_to_path() {
    local uri="$1"
    local path="${uri#file://}"
    echo "$path"
}

# Main script

# Enable bash-completion
complete -F complete_path -o default -o nospace -o filenames read -e -i input_path

# Prompt user for input path
read -e -i "$input_path" -p "Enter the path to the file or folder: " input_path

# Convert URI to local path
input_path=$(convert_uri_to_path "$input_path")

# Expand the path to handle "~" properly
input_path=$(eval echo "$input_path")

# Check if input path is empty
if [ -z "$input_path" ]; then
    display_error "Input path cannot be empty."
fi

# Check if input path exists
if [ ! -e "$input_path" ]; then
    display_error "Input path does not exist."
fi

# Copy file or folder
copy_file_or_folder "$input_path" "$input_path"

exit 0
