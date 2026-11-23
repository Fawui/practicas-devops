#!/usr/bin/env bash
#
# setup.sh -- Instala el monitor con un usuario propio y permisos minimos.
# Ejecutar con: sudo ./setup.sh
#
# Que hace:
#   1. Instala nginx, curl y cron
#   2. Crea el usuario de sistema "monitor" (sin login) y lo agrega al grupo adm
#      (el grupo adm es el que puede leer /var/log/nginx/*)
#   3. Copia el script a /opt/monitor: dueno root, grupo monitor, permisos 750
#      -> monitor puede ejecutarlo pero NO modificarlo
#   4. Crea /var/log/monitor con dueno monitor, permisos 750
#   5. Programa el chequeo cada 5 minutos con cron

set -euo pipefail

if [ "$EUID" -ne 0 ]; then
    echo "Este script necesita root. Ejecutalo con: sudo $0" >&2
    exit 1
fi

cd "$(dirname "$0")"

USUARIO=monitor
DIR_APP=/opt/monitor
DIR_LOG=/var/log/monitor

echo "-> Instalando paquetes..."
apt-get update -qq
apt-get install -y -qq nginx curl cron

echo "-> Creando usuario $USUARIO..."
if ! id "$USUARIO" >/dev/null 2>&1; then
    useradd --system --no-create-home --shell /usr/sbin/nologin "$USUARIO"
fi
usermod -aG adm "$USUARIO"

echo "-> Instalando script en $DIR_APP..."
install -d -o root -g "$USUARIO" -m 750 "$DIR_APP"
install -o root -g "$USUARIO" -m 750 monitor.sh "$DIR_APP/monitor.sh"

echo "-> Creando directorio de logs $DIR_LOG..."
install -d -o "$USUARIO" -g "$USUARIO" -m 750 "$DIR_LOG"

echo "-> Programando cron (cada 5 minutos)..."
echo "*/5 * * * * $USUARIO $DIR_APP/monitor.sh >/dev/null 2>&1" > /etc/cron.d/monitor
chmod 644 /etc/cron.d/monitor

echo "-> Arrancando servicios..."
# En WSL sin systemd se usa 'service'; con systemd funciona igual
service nginx start
service cron start

echo
echo "Instalacion terminada. Probalo a mano con:"
echo "  sudo -u $USUARIO $DIR_APP/monitor.sh"
echo "Y mira el log con:"
echo "  sudo tail -f $DIR_LOG/monitor.log"
