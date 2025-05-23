#!/bin/bash

CONFIG_FILE=".queue-helper.conf"

# Функция загрузки языка
load_language() {
  if [[ -f "$CONFIG_FILE" ]]; then
    LANGUAGE=$(cat "$CONFIG_FILE")
  else
    echo "Select language / Выберите язык:"
    echo "1 - English"
    echo "2 - Русский"
    read -p "Your choice / Ваш выбор (1/2): " lang_choice
    case "$lang_choice" in
      1) LANGUAGE="en" ;;
      2) LANGUAGE="ru" ;;
      *) LANGUAGE="en" ;;
    esac
    echo "$LANGUAGE" > "$CONFIG_FILE"
  fi
}

# Локализация
load_language

t() {
  case $1 in
    "title")
      [[ "$LANGUAGE" == "ru" ]] && echo "📦 Laravel Queue Helper" || echo "📦 Laravel Queue Helper"
      ;;
    "mode_prompt")
      [[ "$LANGUAGE" == "ru" ]] && echo "Выберите режим запуска:" || echo "Select execution mode:"
      ;;
    "mode_1")
      [[ "$LANGUAGE" == "ru" ]] && echo "1 - queue:work (рекомендуется для продакшена)" || echo "1 - queue:work (recommended for production)"
      ;;
    "mode_2")
      [[ "$LANGUAGE" == "ru" ]] && echo "2 - queue:listen (удобно при разработке)" || echo "2 - queue:listen (recommended for development)"
      ;;
    "invalid")
      [[ "$LANGUAGE" == "ru" ]] && echo "❌ Неверный выбор. Прервано." || echo "❌ Invalid choice. Aborted."
      ;;
    "stopping")
      [[ "$LANGUAGE" == "ru" ]] && echo "☠ Завершение всех очередей..." || echo "☠ Stopping all queue processes..."
      ;;
    "stopped_none")
      [[ "$LANGUAGE" == "ru" ]] && echo "✅ Активных очередей не найдено." || echo "✅ No active queue processes found."
      ;;
    "stopped_pids")
      [[ "$LANGUAGE" == "ru" ]] && echo "Завершаются PID: $PIDS" || echo "Killing PIDs: $PIDS"
      ;;
    "starting")
      [[ "$LANGUAGE" == "ru" ]] && echo "🔁 Запуск очереди ($RUN_CMD) в фоне..." || echo "🔁 Starting queue ($RUN_CMD) in background..."
      ;;
    "running")
      [[ "$LANGUAGE" == "ru" ]] && echo "✅ Активные процессы очереди:" || echo "✅ Active queue processes:"
      ;;
    "log_tail")
      [[ "$LANGUAGE" == "ru" ]] && echo "📄 Последние события в $LOG_FILE:" || echo "📄 Last events in $LOG_FILE:"
      ;;
    "done")
      [[ "$LANGUAGE" == "ru" ]] && echo "✅ Готово!" || echo "✅ Done!"
      ;;
  esac
}

echo "$(t title)"
echo "------------------------"
echo "$(t mode_prompt)"
echo "$(t mode_1)"
echo "$(t mode_2)"
read -p "> " mode

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
    echo "$(t invalid)"
    exit 1
    ;;
esac

echo "$(t stopping)"
PIDS=$(ps aux | grep 'php artisan queue:' | grep -v grep | awk '{print $2}')
if [ -n "$PIDS" ]; then
    echo "$(t stopped_pids)"
    kill -9 $PIDS
else
    echo "$(t stopped_none)"
fi

echo "$(t starting)"
if [[ "$RUN_CMD" == *"queue:listen"* ]]; then
    nohup bash -c "$RUN_CMD" > "$LOG_FILE" 2>&1 &
else
    nohup $RUN_CMD > "$LOG_FILE" 2>&1 &
fi

sleep 1
echo "$(t running)"
ps aux | grep 'php artisan queue:' | grep -v grep

echo "$(t log_tail)"
tail -n 10 "$LOG_FILE"

echo "$(t done)"
