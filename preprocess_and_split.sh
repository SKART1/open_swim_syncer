#!/bin/bash

# Function to display help
print_help() {
    echo
    echo "Usage: $0 <file_path> <part_size_seconds>"
    echo
    echo "Description:"
    echo "  This script processes an audio file by increasing its volume by 50%, normalizing it,"
    echo "  and then splitting it into smaller parts based on the specified duration."
    echo
    echo "Arguments:"
    echo "  <file_path>           The path to the audio file to be processed."
    echo "  <part_size_seconds>   The duration of each part in seconds."
    echo
    echo "Example:"
    echo "  $0 /path/to/file.mp3 120"
    echo "  This will process the file.mp3, increase its volume, normalize it, and split it into parts of 120 seconds each."
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

# Check if the second argument is an integer
if ! [ "$2" -eq "$2" ] 2>/dev/null; then
    echo "Error: The second argument must be an integer."
    print_help
    exit 1
fi

full_file_path=$1
part_size_seconds=$2

# Extract file information
base_file_name=$(basename "$full_file_path")
file_name="${base_file_name%.*}"
# Extract file 'extension' only
file_extension="${base_file_name##*.}"
# Extract the directory path from the provided argument
file_directory=$(dirname "$full_file_path")

# Define output file paths
increased_sound="${file_directory}/${file_name}_150.${file_extension}"
normalized="${file_directory}/${file_name}_150_norm.${file_extension}"
splitted="${file_directory}/split/${file_name}_150_norm_part_.${file_extension}"

# Increase volume by 50%
echo "Increasing volume"
sox "${full_file_path}" "${increased_sound}" vol 1.5

# Normalize sound - avoid overload
echo "Normalizing"
sox "${increased_sound}" "${normalized}" gain -n 

# Split into parts of specified duration
echo "Splitting"
mkdir -p "${file_directory}/split"
sox "${normalized}" "${splitted}" trim 0 "$part_size_seconds" : newfile : restart

echo "Process completed. Files have been split into parts of ${part_size_seconds} seconds each and saved in ${file_directory}/split."
