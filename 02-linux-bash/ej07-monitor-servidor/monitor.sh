#!/usr/bin/env bash
#
# monitor.sh -- Chequeo de salud de un servidor Linux
#
# Revisa: recursos (disco, memoria, procesos), estado de un servicio,
# respuesta de un endpoint HTTP y estadisticas del access log de nginx.
# Si algo esta mal escribe una ALERTA en el log y sale con codigo 1.
#
# Todo se puede configurar con variables de entorno, por ejemplo:
#   UMBRAL_DISCO=90 URL=http://localhost:8080 ./monitor.sh

set -euo pipefail   # cortar ante errores, variables sin definir o fallos en pipes

# ---------- Configuracion ----------
LOG_DIR="${LOG_DIR:-/var/log/monitor}"
LOG_FILE="$LOG_DIR/monitor.log"
ACCESS_LOG="${ACCESS_LOG:-/var/log/nginx/access.log}"
URL="${URL:-http://127.0.0.1}"
SERVICIO="${SERVICIO:-nginx}"
UMBRAL_DISCO="${UMBRAL_DISCO:-80}"      # % de disco a partir del cual alerta
UMBRAL_TIEMPO="${UMBRAL_TIEMPO:-2}"     # segundos maximos de respuesta del endpoint

ALERTAS=0

# ---------- Funciones auxiliares ----------
fecha()   { date '+%Y-%m-%d %H:%M:%S'; }
log()     { echo "[$(fecha)] $*" | tee -a "$LOG_FILE"; }
seccion() { log "===== $* ====="; }
alerta()  { log "ALERTA: $*"; ALERTAS=$((ALERTAS + 1)); }

# En WSL systemd puede no estar activo: si no hay systemd, buscamos el proceso.
servicio_activo() {
    if command -v systemctl >/dev/null 2>&1 && [ -d /run/systemd/system ]; then
        systemctl is-active --quiet "$1"
    else
        pgrep -x "$1" >/dev/null
    fi
}

mkdir -p "$LOG_DIR"

# ---------- 1. Recursos ----------
seccion "Recursos"

uso_disco=$(df --output=pcent / | tail -1 | tr -dc '0-9')
log "Disco /: ${uso_disco}% usado"
if (( uso_disco > UMBRAL_DISCO )); then
    alerta "disco al ${uso_disco}% (umbral ${UMBRAL_DISCO}%)"
fi

# free -m -> fila "Mem:": $2 total, $3 usada, $7 disponible
read -r mem_total mem_usada mem_disp < <(free -m | awk '/^Mem:/ {print $2, $3, $7}')
log "Memoria: ${mem_usada} MB usados de ${mem_total} MB (${mem_disp} MB disponibles)"

log "Top 5 procesos por CPU:"
# Se usa awk 'NR<=6' en lugar de head: head cierra el pipe antes de tiempo
# y con 'pipefail' eso puede hacer fallar el script.
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | awk 'NR<=6' | tee -a "$LOG_FILE"

# ---------- 2. Servicio ----------
seccion "Servicio"

if servicio_activo "$SERVICIO"; then
    log "Servicio $SERVICIO: ACTIVO"
else
    alerta "el servicio $SERVICIO no esta corriendo"
fi

# ---------- 3. Endpoint HTTP ----------
seccion "Endpoint"

# -w imprime el codigo HTTP y el tiempo total; si curl falla, el codigo queda en 000
resultado=$(curl -s -o /dev/null -w '%{http_code} %{time_total}' --max-time 5 "$URL" || true)
read -r codigo tiempo <<< "${resultado:-000 0}"
log "GET $URL -> HTTP $codigo en ${tiempo}s"

if [ "$codigo" != "200" ]; then
    alerta "$URL respondio $codigo"
elif awk -v t="$tiempo" -v max="$UMBRAL_TIEMPO" 'BEGIN {exit !(t > max)}'; then
    alerta "$URL tardo ${tiempo}s (umbral ${UMBRAL_TIEMPO}s)"
fi

# ---------- 4. Analisis de logs ----------
seccion "Access log"

if [ -r "$ACCESS_LOG" ]; then
    total=$(wc -l < "$ACCESS_LOG")
    log "Requests totales: $total"

    log "Top 5 IPs:"
    awk '{print $1}' "$ACCESS_LOG" | sort | uniq -c | sort -rn | awk 'NR<=5 {printf "    %-15s %s requests\n", $2, $1}' | tee -a "$LOG_FILE"

    # En el formato de log de nginx, el campo 9 es el codigo de estado
    errores_4xx=$(awk '$9 ~ /^4[0-9][0-9]$/ {c++} END {print c+0}' "$ACCESS_LOG")
    errores_5xx=$(awk '$9 ~ /^5[0-9][0-9]$/ {c++} END {print c+0}' "$ACCESS_LOG")
    log "Errores 4xx: $errores_4xx | Errores 5xx: $errores_5xx"

    log "Top 3 rutas con error 4xx:"
    awk '$9 ~ /^4/ {print $7}' "$ACCESS_LOG" | sort | uniq -c | sort -rn | awk 'NR<=3 {printf "    %-20s %s veces\n", $2, $1}' | tee -a "$LOG_FILE"

    if (( errores_5xx > 0 )); then
        alerta "hay $errores_5xx errores 5xx en el access log"
    fi
else
    alerta "no se puede leer $ACCESS_LOG (no existe o el usuario no tiene permisos)"
fi

# ---------- Resumen ----------
seccion "Resumen"
if (( ALERTAS > 0 )); then
    log "Chequeo terminado con $ALERTAS alerta(s)"
    exit 1
fi
log "Chequeo OK, sin alertas"
