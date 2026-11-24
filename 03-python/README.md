# 03 - Python

Ejercicios de práctica del tema Python de la ruta DevOps.
Todos se corren en WSL (Ubuntu) con `python3 nombre_del_script.py`

## Estructura

```
03-python/
├── README.md
├── datos/
│   └── app.log            # log de ejemplo para los ejercicios 5 y 6
├── 01_strings.py
├── 02_condicionales.py
├── 03_bucles.py
├── 04_funciones.py
├── 05_archivos.py
└── 06_analizador_logs.py  # mini proyecto final
```

---

## Parte A: lo que vi en el curso (métodos de strings)

### 01_strings.py: Normalizar nombres de servidores

El script tiene que imprimir:
1. El nombre sin espacios al principio ni al final (`strip`)
2. Todo en minúsculas (`lower`)
3. Solo el nombre corto, antes del primer punto (`split`)
4. El entorno (`prod`), sacado del nombre (`split` con `-`)
5. Si el nombre termina en `.local` (`endswith`)
6. El nombre con `prod` reemplazado por `qa` (`replace`)
7. Una línea formateada con f-string: `Servidor: web-prod-01 | Entorno: prod`

---

## Parte B: lo que le faltó al curso

### 02_condicionales.py: Semáforo de uso de disco
Pedí al usuario un porcentaje de uso de disco con `input()` y convertilo con `int()`.
- Menor a 70 → `OK`
- Entre 70 y 89 → `WARNING`
- 90 o más → `CRITICAL`
- Si escribe algo que no es número o un valor fuera de 0-100 → mensaje de error (usá `.isdigit()`)

### 03_bucles.py: Revisar una lista de servicios
```python
servicios = {"nginx": "running", "postgres": "stopped", "redis": "running", "api": "stopped"}
```
1. Recorré el diccionario con `for` e imprimí cada servicio con su estado
2. Contá cuántos están caídos (`stopped`) y mostralo al final
3. Con un `while`, simulá 3 reintentos de reinicio de `postgres`: `Intento 1/3...` y en el tercero `postgres levantado`

### 04_funciones.py: Validador de nombres de recursos
Escribí una función `es_nombre_valido(nombre)` que devuelva `True` o `False` según estas reglas (parecidas a las de Azure):
- Entre 3 y 24 caracteres
- Solo letras minúsculas, números y guiones
- No empieza ni termina con guion

Probala con una lista de nombres e imprimí el resultado de cada uno:
```python
nombres = ["stprod01", "St-Prod", "-api", "ab", "web-backend-qa", "nombre-demasiado-largo-para-azure"]
```

---

## Parte C: Python para DevOps

### 05_archivos.py: Leer un log
Abrí `datos/app.log` con `with open(...)` y:
1. Mostrá cuántas líneas tiene
2. Imprimí solo las líneas que contienen `ERROR`
3. Guardá esas líneas de error en un archivo nuevo `datos/errores.txt`

### 06_analizador_logs.py: Mini proyecto
Un script que reciba la ruta del log como argumento:
```bash
python3 06_analizador_logs.py datos/app.log
```
y genere un resumen:
```
Resumen de datos/app.log
- INFO: 8
- WARNING: 4
- ERROR: 5
Servicio con más errores: payments
```
Pistas: `sys.argv` para el argumento, un diccionario para contar, y `split()` para separar cada línea.
Extra: si el archivo no existe, mostrar un mensaje claro en lugar de un error de Python (`try` / `except FileNotFoundError`).

---

## Checklist
- [ ] 01_strings.py
- [ ] 02_condicionales.py
- [ ] 03_bucles.py
- [ ] 04_funciones.py
- [ ] 05_archivos.py
- [ ] 06_analizador_logs.py
