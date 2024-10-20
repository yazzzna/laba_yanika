#!/bin/bash
# Проверяем, передан ли аргумент
if [ $# -lt 2 ]; then
    echo "Введите: $0 <путь_к_папке> <%_заполнения>"
    exit 1
fi

# Путь к папке
DIR="$1"
THRESHOLD="$2"
mkdir -p back_up

# Проверяем, существует ли папка
if [ ! -d "$DIR" ]; then
    echo "Ошибка: Папка '$DIR' не существует."
    exit 1
fi

# Получаем информацию о файловой системе, где находится папка
USAGE=$(df "$DIR" | awk 'NR==2 {print $5}' | sed 's/%//')

# Выводим результат
echo "Заполнение папки '$DIR': $USAGE%"

while [ "$USAGE" -gt "$THRESHOLD" ]; do
    echo "Заполнение превышает порог в $THRESHOLD%. Удаляем самые старые файлы..." # Находим и удаляем самый старый файл
    OLDEST_FILE=$DIR/$(ls -t $DIR | head -n1)

    if [ -n "$OLDEST_FILE" ]; then
        mv $OLDEST_FILE back_up
        echo "Удален файл: $OLDEST_FILE"
    else
        echo "Нет файлов для удаления."
        break
    fi

    # Обновляем информацию о заполнении
    USAGE=$(df "$DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
done

# Выводим результат
echo "Заполнение папки upgrade '$DIR': $USAGE%"
