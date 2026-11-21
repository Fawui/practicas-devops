#!/usr/bin/env bash
# trabajador.sh - Proceso de larga duracion que responde a senales
LOG=/tmp/trabajador.log

log() { echo "$(date +%T) [PID $$] $*" >> "$LOG"; }

trap 'log "SIGTERM recibido: cierre limpio"; exit 0' SIGTERM
trap 'log "SIGHUP recibido: recargando configuracion"' SIGHUP

log "iniciado"
while true; do
    log "trabajando..."
    sleep 2 &      # sleep en segundo plano + wait: asi bash atiende
    wait $!        # las senales al instante y no al terminar el sleep
done
