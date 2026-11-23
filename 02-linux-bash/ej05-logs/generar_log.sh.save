#!/usr/bin/env bash
# generar_log.sh - Genera un log de aplicacion de prueba (app.log)
# Uso: ./generar_log.sh [lineas]   (por defecto 500)

LINEAS="${1:-500}"
SERVICIOS=(api api api auth db)
RUTAS=(/usuarios /productos /pedidos /login /pagos)
USUARIOS=(eli iri ana beto fawy)

for ((i = 0; i < LINEAS; i++)); do
    hora=$(printf "%02d:%02d:%02d" $((8 + i * 10 / LINEAS)) $((RANDOM % 60)) $((RANDOM % 60)))
    r=$((RANDOM % 100))
    if   (( r < 80 )); then nivel=INFO;  estado=200
    elif (( r < 92 )); then nivel=WARN;  estado=404
    else                    nivel=ERROR; estado=500
    fi
    servicio=${SERVICIOS[RANDOM % ${#SERVICIOS[@]}]}
    ruta=${RUTAS[RANDOM % ${#RUTAS[@]}]}
    usuario=${USUARIOS[RANDOM % ${#USUARIOS[@]}]}
    ms=$((RANDOM % 300 + 20))
    (( RANDOM % 15 == 0 )) && ms=$((ms + 1500))     # algunas requests lentas
    echo "2026-11-22 $hora $nivel [$servicio] GET $ruta $estado ${ms}ms user=$usuario"
done | sort -k2 > app.log

echo "Generado app.log con $LINEAS lineas"
