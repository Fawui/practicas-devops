# Ejercicio 7 - Proyecto final: monitor de servidor

Script que hace un chequeo de salud de un servidor con nginx y se ejecuta solo cada 5 minutos con cron. Junta todo lo visto en los ejercicios 1 a 6.

## Archivos

- `monitor.sh`: el chequeo
- `setup.sh`: instala el monitor con un usuario propio, permisos minimos y cron
- `generar_trafico.sh`: genera requests de prueba contra nginx

## Que revisa

| Chequeo | Comandos | Alerta si... | Visto en |
|---|---|---|---|
| Disco y memoria | df, free | el disco supera el 80% | ej01 |
| Procesos | ps | (informa top 5 por CPU) | ej01, ej04 |
| Servicio | systemctl | nginx no esta corriendo | ej02 |
| Endpoint | curl | no responde 200 o tarda mas de 2 s | ej02, ej06 |
| Access log | awk, sort, uniq | hay errores 5xx | ej05 |
| Usuario y permisos | useradd, chmod | - | ej03 |
| Automatizacion | cron | - | ej04 |

Sale con codigo 1 si hubo alertas y 0 si todo esta bien.

## Instalacion y uso

    chmod +x *.sh
    sudo ./setup.sh
    ./generar_trafico.sh 100
    sudo -u monitor /opt/monitor/monitor.sh
    sudo tail -f /var/log/monitor/monitor.log

## Permisos (minimo privilegio)

- Usuario de sistema `monitor`, sin login, en el grupo `adm` para poder leer los logs de nginx.
- `/opt/monitor/monitor.sh`: root:monitor, 750. El usuario lo ejecuta pero no lo puede modificar.
- `/var/log/monitor/`: monitor:monitor, 750.
- Cron en `/etc/cron.d/monitor` cada 5 minutos.

## Configuracion

Variables de entorno opcionales: `UMBRAL_DISCO` (80), `UMBRAL_TIEMPO` (2), `URL` (http://127.0.0.1), `SERVICIO` (nginx), `LOG_DIR`, `ACCESS_LOG`.

    UMBRAL_DISCO=90 ./monitor.sh

## Posibles mejoras

- Rotacion del log con logrotate
- Enviar alertas a Slack o por mail
- Leer varios servicios desde un archivo de configuracion
