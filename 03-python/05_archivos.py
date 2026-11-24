with open("datos/app.log", "r") as archivo:
    lineas = archivo.readlines()

print(f"El log tiene {len(lineas)} líneas")

errores = []
for linea in lineas:
    if "ERROR" in linea:
        print(linea.strip())
        errores.append(linea)        

with open("datos/errores.txt", "w") as salida:
    for e in errores:
        salida.write(e)
        