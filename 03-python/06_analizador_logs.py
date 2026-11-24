import sys

ruta = sys.argv[1]

try:
    with open(ruta, "r") as archivo:
        lineas = archivo.readlines()
except FileNotFoundError:
    print(f"Error: no se encontró el archivo {ruta}")
    sys.exit(1)

niveles = {}
errores_por_servicio = {}

for linea in lineas:
    partes = linea.split()
    nivel = partes[2]
    servicio = partes[3]

    niveles[nivel] = niveles.get(nivel, 0) + 1

    if nivel == "ERROR":
        errores_por_servicio[servicio] = errores_por_servicio.get(servicio, 0) + 1

print(f"Resumen de {ruta}")
for nivel, cantidad in niveles.items():
    print(f"- {nivel}: {cantidad}")

print(f"Servicio con más errores: {max(errores_por_servicio, key=errores_por_servicio.get)}")