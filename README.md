# Laravel Queue Helper PM2

📦 Утилита для удобного управления очередями Laravel (`queue:work`, `queue:listen`) через PM2 **без root**.

---

## 🇷🇺 Русский

### 🔧 Возможности

* Запуск и остановка очередей Laravel (`queue:work`, `queue:listen`) через PM2
* Автоматическое завершение старых процессов перед запуском новых
* Настройка числа потоков, памяти, количества попыток, имени очереди, логов
* Интерактивное меню на русском/английском
* Автоматическая установка PM2 без root в `$HOME/.local/bin`
* Проверка и активация автозапуска PM2 (systemd)
* Просмотр логов и статуса
* Автоматическое сохранение состояния процессов (`pm2 save`)

### 📦 Установка

```bash
curl -o queue-helper.sh https://raw.githubusercontent.com/bau-studio/laravel-queue-helper/main/queue-helper.sh
chmod +x queue-helper.sh
./queue-helper.sh
```

### 🚀 Использование

```bash
./queue-helper.sh
```

Меню:

```
1 - Запустить очередь
2 - Остановить очередь
3 - Статус
4 - Очистить лог
5 - Сменить язык
6 - Перезапустить очередь
7 - Показать логи очереди
8 - Проверить автозапуск pm2
9 - Включить автозапуск pm2
```

#### Запуск очереди

Будет предложено выбрать режим, имя очереди, количество потоков, память, файл лога и др.
Скрипт сам остановит старые процессы и запустит новые с нужными параметрами.

#### Автозапуск PM2

* Для автозапуска процессов после ребута — используйте пункт 9 ("Включить автозапуск pm2").
* После изменений состава очередей автозапуск сохраняется автоматически.

#### Логи

* По умолчанию:

  * `storage/logs/queue.log` — для `queue:work`
  * `storage/logs/queue-dev.log` — для `queue:listen`

### 📝 Пример сценария работы

1. Первый запуск — скрипт предложит установить pm2, если он не найден.
2. Запуск очереди — выбираешь параметры (имя, потоки, лог и т.д.), очередь стартует через pm2.
3. Любые изменения — процессы старые останавливаются, новые стартуют.
4. Для автозапуска после ребута сервера — нажми 9, команды и состояние сохраняются.

---

## 🇬🇧 English

### 🔧 Features

* Start and stop Laravel queues (`queue:work`, `queue:listen`) via PM2
* Automatically stops old processes before starting new ones
* Configure threads, memory, tries, queue name, logs
* Interactive menu (Russian/English)
* PM2 auto-installs without root to `$HOME/.local/bin`
* Check and enable PM2 startup (systemd)
* View logs and process status
* Automatically saves the PM2 process list (`pm2 save`)

### 📦 Installation

```bash
curl -o queue-helper.sh https://raw.githubusercontent.com/bau-studio/laravel-queue-helper/main/queue-helper.sh
chmod +x queue-helper.sh
./queue-helper.sh
```

### 🚀 Usage

```bash
./queue-helper.sh
```

Menu:

```
1 - Start queue
2 - Stop queue
3 - Status
4 - Clear log
5 - Change language
6 - Restart queue
7 - Show queue logs
8 - Check pm2 startup
9 - Enable pm2 startup
```

#### Queue start

You will be prompted to set mode, queue name, threads, memory, log file, etc.
Script stops any previous queue processes and launches new ones with chosen params.

#### PM2 Autostart

* To enable queue startup after reboot, use option 9 ("Enable pm2 startup").
* Any queue config change is auto-saved (`pm2 save`).

#### Logs

* By default:

  * `storage/logs/queue.log` — for `queue:work`
  * `storage/logs/queue-dev.log` — for `queue:listen`

### 📝 Typical workflow

1. First launch — script will offer to install pm2 if not found.
2. Start queue — choose options (name, threads, log, etc.), queue starts with pm2.
3. Changes — old processes stopped, new ones started as needed.
4. For process persistence after reboot, use option 9 — startup config and state saved.

---

## ❤️ Contributing

Pull requests welcome!
Нашли баг? Форкайте или создайте issue.

## 📄 License

🆓 This project is released into the **public domain** via [The Unlicense](https://unlicense.org/).
Вы можете делать с этим проектом **что угодно**, без ограничений, без указания автора.
