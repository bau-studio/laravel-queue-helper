#!/bin/bash
export PATH="$PATH:$HOME/.local/bin"

CONFIG_FILE=".queue-helper.conf"
PROJECT_DIR=$(pwd)
PHP_PATH=$(which php)

DEF_QUEUE="default"
DEF_TRIES="3"
DEF_MEMORY="128"
DEF_LOG_WORK="storage/logs/queue.log"
DEF_LOG_LISTEN="storage/logs/queue-dev.log"
DEF_NUMPROCS="1"

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

t() {
  case $1 in
    "title") [[ "$LANGUAGE" == "ru" ]] && echo "⚙️ Менеджер очередей PM2" || echo "⚙️ Queue Manager PM2";;
    "pm2_1") [[ "$LANGUAGE" == "ru" ]] && echo "1 - Запустить очередь" || echo "1 - Start queue";;
    "pm2_2") [[ "$LANGUAGE" == "ru" ]] && echo "2 - Остановить очередь" || echo "2 - Stop queue";;
    "pm2_3") [[ "$LANGUAGE" == "ru" ]] && echo "3 - Статус" || echo "3 - Status";;
    "pm2_4") [[ "$LANGUAGE" == "ru" ]] && echo "4 - Очистить лог" || echo "4 - Clear log";;
    "pm2_5") [[ "$LANGUAGE" == "ru" ]] && echo "5 - Сменить язык" || echo "5 - Change language";;
    "pm2_6") [[ "$LANGUAGE" == "ru" ]] && echo "6 - Перезапустить очередь" || echo "6 - Restart queue";;
    "pm2_7") [[ "$LANGUAGE" == "ru" ]] && echo "7 - Показать логи очереди" || echo "7 - Show queue logs";;
    "pm2_8") [[ "$LANGUAGE" == "ru" ]] && echo "8 - Проверить автозапуск pm2" || echo "8 - Check pm2 startup";;
    "pm2_9") [[ "$LANGUAGE" == "ru" ]] && echo "9 - Включить автозапуск pm2" || echo "9 - Enable pm2 startup";;

    "pm2_not_found") [[ "$LANGUAGE" == "ru" ]] && echo "❌ pm2 не найден. Установить сейчас?" || echo "❌ pm2 not found. Install now?";;
    "install_choice1") [[ "$LANGUAGE" == "ru" ]] && echo "1 - Установить pm2 в \$HOME/.local (рекомендуется)" || echo "1 - Install pm2 to \$HOME/.local (recommended)";;
    "install_choice2") [[ "$LANGUAGE" == "ru" ]] && echo "2 - Выйти" || echo "2 - Exit";;
    "installing") [[ "$LANGUAGE" == "ru" ]] && echo "⏳ Устанавливаем pm2..." || echo "⏳ Installing pm2...";;
    "success_install") [[ "$LANGUAGE" == "ru" ]] && echo "✅ pm2 установлен!" || echo "✅ pm2 installed!";;
    "need_path") [[ "$LANGUAGE" == "ru" ]] && echo "Добавьте \$HOME/.local/bin в PATH и перезапустите терминал:" || echo "Add \$HOME/.local/bin to PATH and restart terminal:";;
    "queue_pm2_stopped") [[ "$LANGUAGE" == "ru" ]] && echo "✅ Очередь pm2 остановлена." || echo "✅ PM2 queue stopped.";;
    "queue_pm2_running") [[ "$LANGUAGE" == "ru" ]] && echo "✅ Очередь pm2 запущена." || echo "✅ PM2 queue running.";;
    "queue_pm2_restarted") [[ "$LANGUAGE" == "ru" ]] && echo "♻️ Очередь pm2 перезапущена." || echo "♻️ PM2 queue restarted.";;
    "queue_pm2_logs") [[ "$LANGUAGE" == "ru" ]] && echo "Логи очереди laravel-queue:" || echo "Queue logs laravel-queue:";;
    "startup_check") [[ "$LANGUAGE" == "ru" ]] && echo "pm2 startup status:" || echo "pm2 startup status:";;
    "startup_enable") [[ "$LANGUAGE" == "ru" ]] && echo "Попытка включить автозапуск pm2..." || echo "Trying to enable pm2 startup...";;

    "log_cleared") [[ "$LANGUAGE" == "ru" ]] && echo "✅ Лог очищен." || echo "✅ Log cleared.";;

    "done") [[ "$LANGUAGE" == "ru" ]] && echo "✅ Готово!" || echo "✅ Done!";;
    "mode_prompt") [[ "$LANGUAGE" == "ru" ]] && echo "Режим работы:" || echo "Select mode:";;
    "mode_1") [[ "$LANGUAGE" == "ru" ]] && echo "1 - queue:work (продакшн)" || echo "1 - queue:work (production)";;
    "mode_2") [[ "$LANGUAGE" == "ru" ]] && echo "2 - queue:listen (разработка)" || echo "2 - queue:listen (development)";;
    "invalid") [[ "$LANGUAGE" == "ru" ]] && echo "❌ Неверный выбор." || echo "❌ Invalid choice.";;
    "start_fail") [[ "$LANGUAGE" == "ru" ]] && echo "❌ Ошибка запуска очереди. Проверьте логи." || echo "❌ Failed to start queue. Check logs.";;
    *) echo "";;
  esac
}

load_language

if ! command -v pm2 >/dev/null 2>&1; then
  echo "$(t pm2_not_found)"
  echo "$(t install_choice1)"
  echo "$(t install_choice2)"
  read -p "> " install_pm2
  case "$install_pm2" in
    1)
      echo "$(t installing)"
      npm install --prefix ~/.local -g pm2
      echo 'export PATH=$PATH:$HOME/.local/bin' >> ~/.bashrc
      export PATH=$PATH:$HOME/.local/bin
      if command -v pm2 >/dev/null 2>&1; then
        echo "$(t success_install)"
      else
        echo "$(t need_path)"
        echo 'export PATH=$PATH:$HOME/.local/bin'
        exit 1
      fi
      ;;
    2)
      exit 1
      ;;
    *)
      echo "$(t invalid)"; exit 1;;
  esac
fi

echo "$(t title)"
echo "------------------------"
echo "$(t pm2_1)"
echo "$(t pm2_2)"
echo "$(t pm2_3)"
echo "$(t pm2_4)"
echo "$(t pm2_5)"
echo "$(t pm2_6)"
echo "$(t pm2_7)"
echo "$(t pm2_8)"
echo "$(t pm2_9)"
read -p "> " pm2_action
case "$pm2_action" in
  1)
    echo "$(t mode_prompt)"
    echo "$(t mode_1)"
    echo "$(t mode_2)"
    read -p "> " mode
    case "$mode" in
      1)
        ARTISAN_CMD="queue:work"
        DEFAULT_LOG="$DEF_LOG_WORK"
        ;;
      2)
        ARTISAN_CMD="queue:listen"
        DEFAULT_LOG="$DEF_LOG_LISTEN"
        ;;
      *)
        echo "$(t invalid)"; exit 1;;
    esac

    read -p "Имя очереди (ENTER по умолчанию: $DEF_QUEUE): " queue
    [[ -z "$queue" ]] && queue="$DEF_QUEUE"
    ARTISAN_CMD="$ARTISAN_CMD --queue=$queue"

    read -p "Максимум попыток (ENTER по умолчанию: $DEF_TRIES): " tries
    [[ -z "$tries" ]] && tries="$DEF_TRIES"
    ARTISAN_CMD="$ARTISAN_CMD --tries=$tries"

    read -p "Ограничение памяти MB (ENTER по умолчанию: $DEF_MEMORY): " mem
    [[ -z "$mem" ]] && mem="$DEF_MEMORY"
    ARTISAN_CMD="$ARTISAN_CMD --memory=$mem"

    read -p "Файл лога (ENTER по умолчанию: $DEFAULT_LOG): " logf
    [[ -z "$logf" ]] && logf="$DEFAULT_LOG"

    read -p "Введите число процессов (по умолчанию: $DEF_NUMPROCS): " numprocs
    [[ ! $numprocs =~ ^[0-9]+$ ]] && numprocs=$DEF_NUMPROCS
    [[ $numprocs -lt 1 ]] && numprocs=1
    [[ $numprocs -gt 16 ]] && numprocs=16

    pm2 delete laravel-queue >/dev/null 2>&1
    pm2 start bash --name laravel-queue -i $numprocs --output "$logf" --error "$logf" -- -c "$PHP_PATH $PROJECT_DIR/artisan $ARTISAN_CMD"
    sleep 1
    pm2 save
    ONLINE_COUNT=$(pm2 status laravel-queue | grep 'laravel-queue' | grep -c 'online')
    if [[ "$ONLINE_COUNT" -gt 0 ]]; then
      echo "$(t queue_pm2_running)"
    else
      echo "$(t start_fail)"
    fi
    echo "$(t done)"
    ;;
  2)
    pm2 stop laravel-queue
    echo "$(t queue_pm2_stopped)"
    ;;
  3)
    pm2 status laravel-queue
    ;;
  4)
    pm2 flush
    echo "$(t log_cleared)"
    ;;
  5)
    rm -f "$CONFIG_FILE"
    exec "$0"
    ;;
  6)
    pm2 restart laravel-queue
    echo "$(t queue_pm2_restarted)"
    ;;
  7)
    echo "$(t queue_pm2_logs)"
    pm2 logs laravel-queue --lines 50
    ;;
  8)
    echo "$(t startup_check)"
    pm2 startup
    ;;
  9)
    echo "$(t startup_enable)"
    pm2 startup
    pm2 save
    ;;
  *)
    echo "$(t invalid)"
    exit 1
    ;;
esac
