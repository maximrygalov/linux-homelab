#!/bin/bash
set -e

echo "🔧 Установка nginx..."
sudo apt update
sudo apt install -y nginx

echo "📝 Создание кастомной HTML-страницы..."
sudo mkdir -p /var/www/homelab
sudo tee /var/www/homelab/index.html > /dev/null << 'HTML'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Linux Homelab</title>
    <style>body { font-family: Arial; text-align: center; padding: 50px; background: #f4f4f4; }</style>
</head>
<body>
    <h1>🐧 Linux Homelab</h1>
    <p><strong>by Maxim Rygalov</strong></p>
    <p>System Administrator</p>
    <p>Status: ✅ Running on WSL2</p>
</body>
</html>
HTML

echo "⚙️ Настройка nginx..."
sudo tee /etc/nginx/sites-available/homelab << 'NGINX'
server {
    listen 80;
    server_name localhost;
    root /var/www/homelab;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }
}
NGINX

sudo ln -sf /etc/nginx/sites-available/homelab /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

echo "✅ Готово! Открой в браузере Windows: http://localhost"
