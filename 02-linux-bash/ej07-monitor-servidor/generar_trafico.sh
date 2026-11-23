#!/usr/bin/env bash
#
# generar_trafico.sh -- Genera requests de prueba contra nginx local
# para que el access log tenga datos que analizar.
#
# Usa varias IPs de loopback (127.0.0.1 a 127.0.0.5) como origen,
# asi el "Top 5 IPs" del monitor no muestra siempre la misma.
#
# Uso: ./generar_trafico.sh [cantidad]   (por defecto 50)

set -euo pipefail

CANTIDAD="${1:-50}"
RUTAS=("/" "/" "/" "/index.html" "/no-existe" "/admin" "/api/usuarios" "/login.php")

for ((i = 1; i <= CANTIDAD; i++)); do
    ip="127.0.0.$(( RANDOM % 5 + 1 ))"
    ruta="${RUTAS[RANDOM % ${#RUTAS[@]}]}"
    curl -s -o /dev/null --interface "$ip" "http://127.0.0.1$ruta" || true
done

echo "Listo: $CANTIDAD requests enviados a http://127.0.0.1"
