#!/usr/bin/env bash
# analizar.sh - Analiza app.log con grep, sed y awk
# Formato: fecha hora NIVEL [servicio] METODO ruta estado tiempo user=usuario
#          $1    $2   $3    $4         $5     $6   $7     $8     $9

LOG="${1:-app.log}"
[ -r "$LOG" ] || { echo "No se puede leer $LOG"; exit 1; }

echo "===== Analisis de $LOG ====="
echo "Total de lineas: $(wc -l < "$LOG")"

echo
echo "== Lineas por nivel (awk)"
awk '{ c[$3]++ } END { for (n in c) printf "  %-6s %d\n", n, c[n] }' "$LOG" | sort

echo
echo "== Errores (grep)"
echo "Cantidad: $(grep -c ' ERROR ' "$LOG")"
echo "Ultimos 3:"
grep ' ERROR ' "$LOG" | tail -3 | sed 's/^/  /'

echo
echo "== Errores por hora"
grep ' ERROR ' "$LOG" | awk '{ print substr($2, 1, 2) ":00" }' | sort | uniq -c | awk '{ printf "  %s  %s errores\n", $2, $1 }'

echo
echo "== Rutas con mas errores 500"
awk '$7 == 500 { print $6 }' "$LOG" | sort | uniq -c | sort -rn | awk 'NR <= 3 { printf "  %-12s %s\n", $2, $1 }'

echo
echo "== Tiempo promedio por servicio (awk)"
awk '{ t = $8; sub(/ms/, "", t); suma[$4] += t; n[$4]++ }
     END { for (s in suma) printf "  %-8s %6.1f ms\n", s, suma[s] / n[s] }' "$LOG" | sort

echo
echo "== Requests lentas (> 1000 ms)"
echo "Cantidad: $(awk '{ t = $8; sub(/ms/, "", t); if (t + 0 > 1000) c++ } END { print c + 0 }' "$LOG")"

echo
echo "== Anonimizar usuarios (sed)"
sed -E 's/user=[a-z]+/user=***/' "$LOG" > app-anonimizado.log
echo "Generado app-anonimizado.log. Ejemplo:"
head -2 app-anonimizado.log | sed 's/^/  /'
