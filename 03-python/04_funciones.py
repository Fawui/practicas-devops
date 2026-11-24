def es_nombre_valido(nombre):
    if len(nombre) < 3 or len(nombre) > 24:
        return False

    if nombre.startswith("-") or nombre.endswith("-"):
        return False

    for c in nombre:
        if not (c.islower() or c.isdigit() or c == "-"):
            return False

    return True


nombres = ["stprod01", "St-Prod", "-api", "ab", "web-backend-qa", "nombre-demasiado-largo-para-azure"]

for n in nombres:
    print(f"{n}: {es_nombre_valido(n)}")