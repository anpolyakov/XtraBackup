# XtraBackup

Структура проекта

├── configure_backup          # Конфигурационный файл содержащий необходимые перееменные для резервного копирования
├── diff-backup_next.sh       # Скрипт создания следующего инкрементного бэкапа
├── diff-backup.sh            # Скрипт создания первичного инкрементного бэкапа
├── diff-prepare.sh           # Скрипт для подготовки инкрментных бэкапов к восстановлению
├── full-backup.sh            # Скрипт для создания полного бэкапа
├── full-restore.sh           # Скрипт для восстановления полного бэкапа
├── menu-backup.sh            # Скрипт открывающий меню резервного копирования
├── cron                      # Директория в которой находятся скрипты и конфигурационные файлы для настройки и работы cron
│   ├── configure_cron        # Конфигурационный файл содержащий необходиые переменные для настройки cron
│   ├── cron-setup.sh         # Скрипт для иницализации cron
│   ├── diff-backup.job       # Скрипт для создания первичного инкрементного бэкапа через cron
│   ├── diff-backup_next.job  # Скрипт для создания следующего инкрментного бэкапа через cron 
│   └── full-backup.job       # Скрипт для создания полного бэкапа через cron

