# Check if exactly two arguments were passed
if [ "$#" -ne 2 ]; then
    echo "Error: You must provide exactly 2 arguments."
    exit 1
fi

# Check if the second argument is an integer
if ! [ "$2" -eq "$2" ] 2>/dev/null; then
    echo "Error: The second argument must be an integer."
    exit 1
fi

full_file_path=$1
part_size_seconds=$2

# Filename without extension
base_file_name=$(basename "$full_file_path")
file_name="${base_file_name%.*}"
# Extract file 'extension' only
file_extension="${base_file_name##*.}"
# Extract the directory path from the provided argument
file_directory=$(dirname "$full_file_path")


increased_sound=${file_directory}/${file_name}_150.${file_extension}
normalized=${file_directory}/${file_name}_150_norm.${file_extension}
splitted=${file_directory}/split/${file_name}_150_norm_part_.${file_extension}

# Increase volume by 50%
echo "Increasing volume"
sox ${full_file_path} ${increased_sound} vol 1.5

# Normalize sound - avoid overload
echo "Normalizing"
sox ${increased_sound} ${normalized}  gain -n 

# Split
echo "Splitting"
mkdir ${file_directory}/split
sox ${normalized} ${splitted} trim 0 $part_size_seconds : newfile : restart