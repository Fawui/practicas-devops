dato = input("Ingrese el porcentaje de uso de disco: ")

if not dato.isdigit():
    print("Error: Por favor ingrese un valor numérico válido.")
else:
    dato = int(dato)

if dato < 0 or dato > 100:
    print("Error: Por favor ingrese un valor entre 0 y 100.")
elif dato<70:
    print("OK")
elif dato<90:
    print("WARNING")
else:
    print("CRITICAL")