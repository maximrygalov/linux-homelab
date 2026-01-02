#!/bin/bash
set -e

echo "🔒 Настраиваем безопасность..."

# 1. Установка UFW и Fail2ban
echo "🔧 Установка UFW и Fail2ban..."
sudo apt update
sudo apt install -y ufw fail2ban

# 2. Настройка UFW (разрешить только SSH, HTTP)
echo "🛡️ Настраиваем фаервол UFW..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 80/tcp comment 'HTTP'
sudo ufw --force enable

# 3. Настройка SSH (только ключи, без root)
echo "🔑 Настраиваем SSH..."
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config

# Важно: в WSL SSH-сервер по умолчанию НЕ запущен, поэтому перезапускать не нужно.
# Но если бы был — делали бы: sudo systemctl reload sshd

# 4. Fail2ban (базовая настройка)
echo "🛡️ Включаем Fail2ban..."
sudo systemctl enable --now fail2ban

echo "✅ Безопасность настроена!"
echo "📌 Важно: убедись, что у тебя есть SSH-ключ, прежде чем применять это на реальном сервере!"
