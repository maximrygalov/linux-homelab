#!/bin/bash
set -e

echo "🔧 Установка PostgreSQL..."
sudo apt update
sudo apt install -y postgresql postgresql-contrib

echo "🔄 Запуск и включение службы..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "📝 Создание пользователя и базы данных..."
sudo -u postgres psql -c "CREATE USER homelab WITH PASSWORD 'secure_password';"
sudo -u postgres psql -c "CREATE DATABASE homelab_db OWNER homelab;"

echo "🗃️ Создание тестовой таблицы..."
sudo -u postgres psql -d homelab_db -c "CREATE TABLE tasks (id SERIAL PRIMARY KEY, name VARCHAR(100), status VARCHAR(20));"
sudo -u postgres psql -d homelab_db -c "INSERT INTO tasks (name, status) VALUES ('Setup homelab', 'completed');"

echo "✅ PostgreSQL готов! База: homelab_db, пользователь: homelab"
