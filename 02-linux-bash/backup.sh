#!/bin/bash

# Este script crea un backup comprimido de una carpeta con la fecha y hora en el nombre del archivo
# Uso: ./backup.sh <carpeta>


# Si no se usa ninguna carpeta mostrar como se usa el script
if [ $# -eq 0 ]; then
    echo "Uso: ./backup.sh <CARPETA>"
    exit 1
fi

# Creacion de variables
CARPETA="$1"
FECHA=$(date +%Y-%m-%d_%H-%M)
NOMBRE=$(basename "$CARPETA")
DESTINO="$HOME/backups/${NOMBRE}_${FECHA}.tar.gz"

# Crear carpeta si no existe
mkdir -p "$HOME/backups"

# Comprimir carpeta
tar -czf "$DESTINO" "$CARPETA"

# Avisa donde quedo el backup
echo "Backup creado: $DESTINO"

