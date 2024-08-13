#!/bin/bash

# Check if exactly two arguments were passed
if [ "$#" -ne 2 ]; then
    echo "Error: You must provide exactly 2 arguments."
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
    sleep 1
done <<< "$files"

echo "Files have been successfully copied to $dst in order preserving creation date order (which will result in sorted)"