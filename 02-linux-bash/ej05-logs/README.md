# Ejercicio 5 - Analisis de logs con grep, sed y awk

- `generar_log.sh`: genera app.log con lineas de prueba
- `analizar.sh`: analiza el log y genera una version anonimizada

## Uso

    ./generar_log.sh
    ./analizar.sh

## Resultado (salida-analisis.txt)

- 46 errores, con un pico de 11 a las 13:00
- /login es la ruta con mas errores 500
- db es el servicio mas lento (317 ms promedio)
- 32 requests tardaron mas de 1000 ms

## Herramientas

| Herramienta    | Para que                                                 |
|----------------|----------------------------------------------------------|
| grep           | Buscar lineas que contienen un texto                     |
| awk            | Trabajar con columnas: filtrar, contar, sumar, promediar |
| sed            | Reemplazar texto (se uso para ocultar usuarios)          |
| sort + uniq -c | Ordenar y contar repetidos                               |

## Formato del log y campos de awk

    2026-11-22 08:00:17 INFO [api] GET /usuarios 200 1658ms user=fawy
        $1        $2     $3   $4   $5    $6      $7   $8      $9
