servicios = {"nginx": "running", "postgres": "stopped", "redis": "running", "api": "stopped"}
contador_stopped = 0
intentos = 0
for servicio, estado in servicios.items():
    print(f"{servicio}: {estado}")
    if estado == "stopped":
        contador_stopped += 1
print(f"Total de servicios detenidos: {contador_stopped}")

print("Intentando reiniciar postgres...")
while intentos < 2:
    print(f"Intento {intentos+1}/3...")
    intentos += 1
print("postgres reiniciado con éxito.")