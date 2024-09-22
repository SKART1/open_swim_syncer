#!/bin/bash

# Function to display help
print_help() {
    echo
    echo "Usage: $0 <source_directory> <destination_directory>"
    echo
    echo "Description:"
    echo "  This script copies files from the source directory to the destination directory"
    echo "  while preserving their creation date order. It creates destination folders if necessary."
    echo
    echo "Arguments:"
    echo "  <source_directory>      The directory containing the files to be copied."
    echo "  <destination_directory> The directory where the files will be copied to."
    echo
    echo "Example:"
    echo "  $0 /path/to/source /media/OpenSwim/6_01/"
    echo
}

# Check if -h flag is passed or no arguments were passed
if [ "$#" -eq 0 ] || [ "$1" == "-h" ]; then
    print_help
    exit 0
fi

# Check if exactly two arguments were passed
if [ "$#" -ne 2 ]; then
    echo "Error: You must provide exactly 2 arguments."
    print_help
    exit 1
fi

src=$1
dst=$2

# Create the target directory if it doesn't exist
mkdir -p "$dst"

# Get the list of files with their creation dates and sort them
files=$(find "$src" -type f -print0 | xargs -0 stat --format '%W %n' | sort -n)

# Copy the files in sorted order
while IFS= read -r line; do
    # Extract the file name from the line
    file=$(echo "$line" | awk '{print substr($0, index($0,$2))}')
    # Copy the file to the target directory
    cp "$file" "$dst"
    sleep 0.05
done <<< "$files"

echo "Files have been successfully copied to $dst in order preserving creation date order - this will cause player to playback them correctly"
