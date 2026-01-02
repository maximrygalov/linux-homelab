#!/bin/bash
set -e

BACKUP_DIR="/home/maxim/linux-homelab/backups"
mkdir -p "$BACKUP_DIR"

# Используем подключение через сокет (без -h), тогда пароль не нужен
DATE=$(date +%Y%m%d_%H%M%S)
DUMP_FILE="$BACKUP_DIR/homelab_db_$DATE.sql"

echo "📦 Делаем дамп базы homelab_db от пользователя postgres (через сокет)..."
sudo -u postgres pg_dump homelab_db > "$DUMP_FILE"

echo "✅ Бэкап сохранён: $DUMP_FILE"

# Оставить только последние 5 бэкапов
(ls -t "$BACKUP_DIR"/homelab_db_*.sql | head -n -5) | xargs -r rm --

echo "🧹 Оставлено только 5 последних бэкапов"
