input_file_name=$1
part_size_seconds=$2


# Filename without extension
file_name="${input_file_name%.*}"
# Extract file 'extension' only
file_extension="${input_file_name##*.}"


# Increase volume by 50%
sox $input_file_name ${file_name}_150.${file_extension} vol 1.5

# Normalize sound - avoid overload
sox ${file_name}_150.${file_extension} ${file_name}_150_norm.${file_extension}  gain -n 

# Split
sox ${file_name}_150_norm.${file_extension} ${file_name}_150_norm_part_.${file_extension} trim 0 $part_size_seconds : newfile : restart