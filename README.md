# Linux Homelab

Учебный проект системного администратора: развёртывание базовой инфраструктуры на Ubuntu (WSL2).

## Состав проекта
- **Web-сервер**: nginx (порт 80)
- **База данных**: PostgreSQL с таблицей `tasks`
- **Резервное копирование**: скрипт `backup-db.sh` + cron
- **Безопасность**: UFW, отключён вход root по SSH, fail2ban

## Как развернуть
```bash
git clone https://github.com/maximrygalov/linux-homelab.git
cd linux-homelab
sudo ./scripts/install-nginx.sh
sudo ./scripts/install-postgres.sh
./scripts/backup-db.sh
```

## Проверка
- Открой в браузере: http://localhost
- Выполни: `sudo -u postgres psql -d homelab_db -c "SELECT * FROM tasks;"`
- Посмотри бэкапы: `ls -l backups/`

## Автор
Maxim Rygalov — системный администратор
GitHub: https://github.com/maximrygalov
