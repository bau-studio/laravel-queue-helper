#!/bin/bash

echo "📦 Laravel Queue Helper"
echo "------------------------"

# 0. Выбор режима
echo "Выберите режим запуска:"
echo "1 - queue:work (рекомендуется для продакшена)"
echo "2 - queue:listen (удобно при разработке)"
read -p "Ваш выбор (1/2): " mode

case "$mode" in
  1)
    RUN_CMD="php artisan queue:work --daemon"
    LOG_FILE="storage/logs/queue.log"
    ;;
  2)
    RUN_CMD="php artisan queue:listen"
    LOG_FILE="storage/logs/queue-dev.log"
    ;;
  *)
    echo "❌ Неверный выбор. Прервано."
    exit 1
    ;;
esac

# 1. Завершить все процессы queue:work и queue:listen
echo "☠ Завершение всех очередей..."
PIDS=$(ps aux | grep 'php artisan queue:' | grep -v grep | awk '{print $2}')
if [ -n "$PIDS" ]; then
    echo "Завершаются PID: $PIDS"
    kill -9 $PIDS
else
    echo "✅ Активных очередей не найдено."
fi

# 2. Запуск выбранного режима
echo "🔁 Запуск очереди ($RUN_CMD) в фоне..."

if [[ "$RUN_CMD" == *"queue:listen"* ]]; then
    nohup bash -c "$RUN_CMD" > "$LOG_FILE" 2>&1 &
else
    nohup $RUN_CMD > "$LOG_FILE" 2>&1 &
fi

# 3. Короткая пауза и проверка
sleep 1
echo "✅ Активные процессы очереди:"
ps aux | grep 'php artisan queue:' | grep -v grep

# 4. Последние строки лога
echo "📄 Последние события в $LOG_FILE:"
tail -n 10 "$LOG_FILE"

echo "✅ Готово!"
