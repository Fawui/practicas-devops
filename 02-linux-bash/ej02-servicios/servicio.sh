#!/usr/bin/env bash
# servicio.sh — Chequea el estado de un servicio systemd
# Uso: ./servicio.sh [servicio] [puerto]   (por defecto: nginx 80)

SERVICIO="${1:-nginx}"
PUERTO="${2:-80}"
PROBLEMAS=0

echo "===== Chequeo de $SERVICIO: $(date '+%Y-%m-%d %H:%M:%S') ====="

if systemctl is-active --quiet "$SERVICIO"; 
then
    echo "Estado: ACTIVO"
else
    echo "Estado: CAÍDO"
    PROBLEMAS=$((PROBLEMAS + 1))
fi

echo "Arranca con el sistema: $(systemctl is-enabled "$SERVICIO" 2>/dev/null)"
echo "PID principal: $(systemctl show -p MainPID --value "$SERVICIO")"

if ss -tln | grep -q ":$PUERTO "; then
    echo "Puerto $PUERTO: ESCUCHANDO"
else
    echo "Puerto $PUERTO: NO ESCUCHA"
    PROBLEMAS=$((PROBLEMAS + 1))
fi

codigo=$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 "http://127.0.0.1:$PUERTO")
echo "Respuesta HTTP: $codigo"
[ "$codigo" = "200" ] || PROBLEMAS=$((PROBLEMAS + 1))

echo "Últimas 5 líneas del log:"
journalctl -u "$SERVICIO" -n 5 --no-pager 2>/dev/null || echo "(sin permisos para leer el journal)"

echo "Problemas encontrados: $PROBLEMAS"
[ "$PROBLEMAS" -eq 0 ]    # el script sale con 0 si todo OK, 1 si hubo problemas
