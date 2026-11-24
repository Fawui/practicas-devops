servidor = "  WEB-Prod-01.Banco.Local  "
print("Palabra original: ", servidor)

print("Palabra sin espacios:",servidor.strip())
print("Palabra en minúsculas:",servidor.lower())
print("Palabra en mayúsculas:",servidor.upper())
print("Palabra dividida por punto:",servidor.split('.')[0])
print("Palabra dividida por guion(imprimir el entorno):",servidor.split('-')[1])
print("Si el nombre termina en `.local`:",servidor.endswith('.local'))
print("Si el nombre termina en `.Local  `:",servidor.endswith('.Local  '))
print("Reemplazo de `prod` por `qa`:",servidor.replace('Prod', 'qa'))
print(f"Una línea formateada con f-string: Servidor: {servidor.split('.')[0].strip()} | Entorno: {servidor.split('-')[1]}")
