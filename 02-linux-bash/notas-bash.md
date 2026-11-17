# Notas de Bash / Shell Scripting

Curso: Intro to Linux Shell Scripting (Udemy)
Entorno: Ubuntu en WSL (Windows)

## 1. Qué es un script y como se ejecuta

Un script es un archivo de texto con comandos que Bash ejecuta en orden
La primera linea `#!/bin/bash` (shebang o shark bang) indica que se ejecuta con Bash

```bash
nano script.sh       # Crear o editar
chmod +x script.sh   # Darle permiso de ejecución
./script.sh          # Ejecutarlo
ls -l script.sh      # Ver permisos: la "x" en -rwxr-xr-x = ejecutable
```

Todo lo que va despues de `#` es un comentario y Bash lo ignora

## 2. Variables

```bash
NOMBRE="Fabricio"          # Sin espacios alrededor del =
echo "Hola $NOMBRE"        # Se usa con $
echo "${NOMBRE}_backup"    # Con llaves cuando va pegada a otro texto
FECHA=$(date +%Y-%m-%d)    # $( ) guarda la salida de un comando
```

- De preferencia usar MAYUSCULAS para una variable
- Usar siempre comillas en las variables: `"$VARIABLE"`
- `$HOME` es mi carpeta personal (`/home/fawy`)

## 3. Argumentos

- `$0` -> nombre del script
- `$1`, `$2` -> primer y segundo argumento
- `$#` -> cantidad de argumentos
- `$@` -> todos los argumentos
- `$?` -> codigo de salida del último comando (0 = salió bien)

## 4. Condicionales

```bash
if [ $# -eq 0 ]; then
    echo "Falta un argumento"
    exit 1
elif [ ! -d "$1" ]; then
    echo "La carpeta no existe"
    exit 1
else
    echo "Todo OK"
fi
```

- `-eq`, `-ne`, `-gt`, `-lt` -> igual, distinto, mayor, menor (numeros)
- `=`, `!=` -> igual, distinto (texto)
- `-d` -> existe y es una carpeta
- `-f` -> existe y es un archivo
- `!` -> niega la condición
- `exit 0` -> terminó bien / `exit 1` -> termino con error

## 5. Comandos que usé

- `mkdir -p carpeta` -> crea la carpeta sin error si ya existe
- `basename /ruta/carpeta` -> devuelve solo el nombre sin la ruta
- `date +%Y-%m-%d_%H-%M` -> fecha y hora con formato
- `tar -czf archivo.tar.gz carpeta` -> comprime (c = crear, z = gzip, f = archivo)
- `cat archivo` -> muestra el contenido de un archivo
