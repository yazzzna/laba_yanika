 #!/bin/bash

# Указываем целевую папку
TARGET_DIR="/home/user/yanika_laba"
TOTAL_SIZE_MB=$(( 4 * 1024 ))
CURRENT_SIZE_MB=0

# Проверяем, существует ли папка, если нет, создаем её
mkdir -p "$TARGET_DIR"

# Генерируем файлы случайного размера
while true
do
    FILE_SIZE_MB=$(shuf -i 500-1000 -n 1)

    # Проверяем, не превышает ли общий размер
    if [ $(( CURRENT_SIZE_MB + FILE_SIZE_MB )) -gt $TOTAL_SIZE_MB ]; then
        break
    fi

    FILE_NAME="$TARGET_DIR/file_$CURRENT_SIZE_MB.bin"

    # Создаем файл указанного размера
    dd if=/dev/zero of="$FILE_NAME" bs=1M count="$FILE_SIZE_MB" status=none
    echo "Создан файл: $FILE_NAME размером $FILE_SIZE_MB MB"
 # Обновляем текущий размер
    CURRENT_SIZE_MB=$(( CURRENT_SIZE_MB + FILE_SIZE_MB ))
done

echo "Заполнение папки завершено. Общий размер: $CURRENT_SIZE_MB MB"
