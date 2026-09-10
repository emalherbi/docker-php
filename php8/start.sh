#!/bin/sh
set -e

# Sobe o servidor de WebSocket de qualquer projeto montado que tenha esse
# script (hoje só foto-live) automaticamente toda vez que o container inicia
# — antes disso era um `docker exec -d` manual que morria sempre que o php8
# reiniciava, e não voltava sozinho. Condicional a existir o arquivo pra não
# quebrar o start de outros projetos que também rodam nesse mesmo container
# e não têm esse script.
FOTO_LIVE_WS="/var/www/html/github/foto-live/backend/bin/websocket-server.php"
if [ -f "$FOTO_LIVE_WS" ]; then
  php "$FOTO_LIVE_WS" >> /var/www/html/github/foto-live/backend/storage/websocket-startup.log 2>&1 &
fi

exec apache2-foreground
