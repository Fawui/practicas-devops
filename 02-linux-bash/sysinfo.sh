#!/bin/bash

# Este script muestra informacion del sistema cuando es ejecutado

# Indicarle al usuario que el script esta comenzando
echo "Iniciando sysinfo script"

# Mostramos el nombre del host de sistema
hostname

# Mostramos la fecha y hora actuales
date

# Mostramos informacion del kernel
uname -r
uname -m

# Mostramos informacion del uso de disco
df -h

# Informamos que el script finalizó
echo  "Finalizando sysinfo script"

