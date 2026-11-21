#!/usr/bin/env bash
# gestionar.sh - Lanza trabajador.sh y le envia distintas senales
LOG=/tmp/trabajador.log
rm -f "$LOG"

estado() {
    ps -o pid,ppid,stat,etime,cmd --no-headers -p "$1" || echo "  (proceso terminado)"
}

echo "== 1. Lanzar en segundo plano"
./trabajador.sh &
PID=$!
sleep 3
echo "PID del trabajador: $PID | PID de este script: $$"
estado "$PID"

echo "== 2. SIGSTOP (pausar)"
kill -STOP "$PID"; sleep 1
estado "$PID"

echo "== 3. SIGCONT (reanudar)"
kill -CONT "$PID"; sleep 1
estado "$PID"

echo "== 4. SIGHUP"
kill -HUP "$PID"; sleep 1

echo "== 5. SIGTERM (cierre limpio)"
kill -TERM "$PID"
wait "$PID"
echo "Codigo de salida: $?"
estado "$PID"

echo "== 6. SIGKILL (cierre forzado)"
./trabajador.sh &
PID2=$!
sleep 3
kill -KILL "$PID2"
wait "$PID2" 2>/dev/null
echo "Codigo de salida: $?"

echo "== Log del trabajador"
cat "$LOG"

