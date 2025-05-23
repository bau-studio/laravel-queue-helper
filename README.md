# Laravel Queue Helper

📦 Simple CLI utility for managing Laravel queues (`queue:work`, `queue:listen`) in a user-friendly way.

📦 Утилита командной строки для управления очередями Laravel (`queue:work`, `queue:listen`) с удобным интерфейсом.

---

## 🌍 Multi-language README  
🇬🇧 [English](#english) | 🇷🇺 [Русский](#русский)

---

## 🇬🇧 English

### 🔧 Features

- Supports `queue:work` (for production) and `queue:listen` (for development)
- Automatically stops existing workers
- Runs jobs in background via `nohup`
- Logs output to separate files
- Interactive terminal menu for easy use

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

You will be prompted:

```
1 - queue:work (recommended for production)
2 - queue:listen (recommended during development)
```

### 📄 Logs

- `storage/logs/queue.log` for `queue:work`
- `storage/logs/queue-dev.log` for `queue:listen`

### 🔜 Roadmap

- Command-line flags: `--dev`, `--prod`
- Auto-cleanup for logs
- Laravel root directory detection

---

## 🇷🇺 Русский

### 🔧 Возможности

- Поддержка `queue:work` (для продакшена) и `queue:listen` (для разработки)
- Завершение старых процессов перед запуском
- Запуск в фоне через `nohup`
- Разделённые логи для прод и дев
- Интерактивное меню в терминале

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

Скрипт предложит выбрать режим:

```
1 - queue:work (рекомендуется для продакшена)
2 - queue:listen (удобно при разработке)
```

### 📄 Логи

- `storage/logs/queue.log` — для `queue:work`
- `storage/logs/queue-dev.log` — для `queue:listen`

### 🔜 Планы

- Поддержка аргументов `--dev`, `--prod`
- Автоматическая очистка логов
- Определение корня Laravel-проекта

---

## ❤️ Contributing

Pull requests welcome! Found a bug? Want to improve UX? Open an issue or fork away.  
Пулл-реквесты приветствуются! Нашли баг? Есть идея? Форкайте или создавайте issue.

## 📄 License

🆓 This project is released into the **public domain** via [The Unlicense](https://unlicense.org/).  
Вы можете делать с этим проектом **что угодно**, без ограничений, без указания автора.

