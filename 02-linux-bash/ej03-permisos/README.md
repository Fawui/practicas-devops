# Ejercicio 3 - Usuarios, grupos y permisos

Se crea el grupo `devops`, dos usuarios y una carpeta compartida, Luego se prueba que puede hacer cada uno

- `eli`: pertenece a devops
- `iri`: no pertenece a devops

## Uso

    sudo ./setup.sh
    sudo ./verificar.sh

## Permisos usados

| Archivo       | Permiso | Dueño | Grupo | Resto |
|---------------|---------|-------|-------|-------|
| /srv/proyecto | 2770    | rwx   | rwx   | ----- |
| app.conf      | 640     | rw-   | r--   | ----- |
| deploy.sh     | 750 	  | rwx	  | r-x   | ----- |

Cada digito es la suma de 4 (leer) + 2 (escribir) + 1 (ejecutar).

## Resultado (salida-verificar.txt)

- eli puede leer la config, ejecutar el script y crear archivos, pero no modificar app.conf porque el grupo solo tiene lectura
- iri no puede hacer nada porque no puede ni entrar a la carpeta
- Con `chmod g+w app.conf` (640 a 660) eli tambien puede modificarla

## Conceptos

- **Grupo**: estar en el grupo da solo los permisos del grupo de cada archivo, no todos
- **Carpetas**: sin permiso sobre la carpeta no se puede acceder a nada de adentro
- **setgid (el 2 de 2770)**: los archivos nuevos heredan el grupo devops
- **umask**: los archivos nuevos se crean con 644 (umask 022), por eso el grupo no puede editarlos
- **Minimo privilegio**: cada usuario tiene solo los permisos que necesita
