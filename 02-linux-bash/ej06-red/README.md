# Ejercicio 6 - Diagnostico de red

Script que revisa la red paso a paso: IP, router, DNS, conectividad, puertos y respuesta HTTP

## Uso

    ./red.sh

## Resultado (salida-red.txt)

| Paso         | Comando          | Resultado                                    |
|--------------|------------------|----------------------------------------------|
| IP           | hostname -I      | 172.27.129.17 (red privada de WSL)           |
| Router       | ip route         | 172.27.128.1 (Windows)                       |
| DNS          | /etc/resolv.conf | 10.255.255.254                               |
| Nombre a IP  | getent           | google y github resuelven, el sitio falso no |
| Conectividad | ping 8.8.8.8     | 0% perdida, ~5 ms                            |
| Puertos      | ss -tln          | 80 (nginx) y 53 (DNS)                        |
| HTTP         | curl             | google 301, github 200, sitio falso 000      |

## Conceptos

- **Orden de diagnostico**: IP -> router -> DNS -> puerto -> servicio.
- **DNS**: traduce nombres a IPs. Si falla, no se llega a conectar (HTTP 000)
- **127.0.0.1 vs 0.0.0.0**: el primero solo acepta conexiones locales, el segundo desde cualquier red
- **Codigos HTTP**: 200 OK, 301 redireccion, 404 no encontrado, 500 error del servidor, 000 sin conexion
