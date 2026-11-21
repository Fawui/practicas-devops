# Ejercicio 4 - Procesos, senales y cron

## Archivos

- `trabajador.sh`: proceso que corre en bucle y maneja SIGTERM y SIGHUP con `trap`
- `gestionar.sh`: lo lanza en segundo plano y le envia senales
- `crontab.txt` / `salida-cron.txt`: ejecución automatica de ej01 cada minuto

## Uso

    ./gestionar.sh

## Senales probadas (salida-senales.txt)

| Senal   | Numero | Efecto                                       | Se puede atrapar |
|---------|--------|----------------------------------------------|------------------|
| SIGSTOP | 19     | Pausa el proceso (STAT = T)                  | No               |
| SIGCONT | 18     | Lo reanuda (STAT = S)                        | Si               |
| SIGHUP  | 1      | Se usa para recargar configuracion           | Si               |
| SIGTERM | 15     | Pide terminar,permite cierre limpio,Codigo 0 | Si               |
| SIGKILL | 9      | Mata el proceso de inmediato. Codigo 137     | No               |

## Conceptos

- **PID / PPID**: id del proceso y de su proceso padre
- **SIGTERM vs SIGKILL**: siempre primero SIGTERM para que el proceso cierre bien. SIGKILL solo si no responde, porque no deja limpiar nada
- **Codigo 137**: 128 + 9. Un proceso muerto por senal sale con 128 + numero de senal. En Docker/Kubernetes suele indicar falta de memoria (OOMKilled)
- **cron**: `* * * * *` = minuto, hora, dia del mes, mes, dia de la semana
