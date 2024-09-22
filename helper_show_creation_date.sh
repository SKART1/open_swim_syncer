#!/bin/bash

# Function to display help
print_help() {
    echo
    echo "Usage: $0 <directory_path>"
    echo
    echo "Description:"
    echo "  This script iterates over all files in the specified directory and displays"
    echo "  their creation date and time. If the creation date is not available, it will"
    echo "  notify you that the information is missing for the specific file."
    echo
    echo "Arguments:"
    echo "  <directory_path>   The path to the directory containing the files."
    echo
    echo "Example:"
    echo "  $0 /path/to/directory"
    echo
}

# Check if -h flag is passed or no arguments were passed
if [ "$#" -eq 0 ] || [ "$1" == "-h" ]; then
    print_help
    exit 0
fi

# Check if exactly one argument (directory path) is provided
if [ "$#" -ne 1 ]; then
    echo "Error: You must provide exactly one argument."
    print_help
    exit 1
fi

path=$1

# Iterate over all files in the specified directory
for file in "$path"/*; do
    if [ -f "$file" ]; then
        birthtime=$(stat --format='%.W' "$file")
        
        # Check if the birth time is available
        if [ "$birthtime" == "0.000000000" ]; then
            echo "Creation time not available for $file"
        else
            # Convert birth time to human-readable format
            creation_date=$(date -d "@$birthtime" +"%Y-%m-%d %H:%M:%S.%3N")
            echo "$file: $creation_date"
        fi
    fi
done
