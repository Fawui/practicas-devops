#!/usr/bin/env bash
# recursos.sh — Muestra uso de disco, memoria y top 5 procesos por CPU

echo "===== Reporte de recursos: $(date '+%Y-%m-%d %H:%M:%S') ====="

disco=$(df --output=pcent / | tail -1 | tr -dc '0-9')
echo "Disco /: ${disco}% usado"

read -r total usada disponible < <(free -m | awk '/^Mem:/ {print $2, $3, $7}')
echo "Memoria: ${usada} MB usados de ${total} MB (${disponible} MB disponibles)"

echo "Top 5 procesos por CPU:"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -6
