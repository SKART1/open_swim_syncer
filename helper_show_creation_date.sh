 #!/bin/bash
path=$1

for file in $path/*; do
    if [ -f "$file" ]; then
        birthtime=$(stat --format='%.W' "$file")
        if [ "$birthtime" == "0.000000000" ]; then
            echo "Creation time not available for $file"
        else
            creation_date=$(date -d "@$birthtime" +"%Y-%m-%d %H:%M:%S.%3N")
            echo "$file: $creation_date"
        fi
    fi
done
