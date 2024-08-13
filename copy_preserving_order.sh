#!/bin/bash

src=$1
dst=$2


# Создаем целевую директорию, если она не существует
mkdir -p "$dst"

# Получаем список файлов с датами создания и сортируем их
files=$(find "$src" -type f -print0 | xargs -0 stat --format '%W %n' | sort -n)

# Копируем файлы в отсортированном порядке
while IFS= read -r line; do
    # Извлекаем имя файла из строки
    file=$(echo "$line" | awk '{print substr($0, index($0,$2))}')
    # Копируем файл в целевую директорию
    cp "$file" "$dst"
    sleep 1
done <<< "$files"

echo "Файлы успешно скопированы в $dst в отсортированном порядке."
