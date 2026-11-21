# Ejercicio 2 - Chequeo de servicios con systemd

Script que verifica si un servicio funciona: estado, si arranca con el sistema, PID, puerto, respuesta HTTP y ultimos logs. Sale con 0 si todo esta bien y 1 si hay problemas

## Uso

```bash
./servicio.sh              # nginx, puerto 80
./servicio.sh nginx 8080   # otro servicio o puerto
```

## Evidencia

- `salida-activo.txt`: nginx corriendo, 0 problemas
- `salida-caido.txt`: nginx detenido, 3 problemas (caido, puerto sin escuchar, HTTP 000)

## Preguntas

**1. start vs enable**
`start` lo prende ahora. `enable` hace que arranque al iniciar el sistema. Son independientes: con nginx detenido sigue figurando como enabled

**2. journalctl -u nginx**
Muestra los logs del servicio. Sirve para ver cuando y por que se cayó

**3. ss -tln**
Lista los puertos abiertos. `t` = TCP, `l` = escuchando, `n` = numeros en vez de nombres

**4. Codigo de salida 0 / 1**
Permite que otras herramientas (cron, CI/CD, Kubernetes) sepan si el chequeo salio bien sin leer el texto.

**5. $? con tee**
Con un pipe, `$?` devuelve el codigo del ultimo comando (`tee`), que siempre da 0. Sin pipe da 1. Para el codigo real se usa `${PIPESTATUS[0]}` o `set -o pipefail`
