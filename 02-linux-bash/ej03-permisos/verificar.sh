#!/usr/bin/env bash
# verificar.sh - Prueba que puede hacer cada usuario en /srv/proyecto
[ "$EUID" -eq 0 ] || { echo "Ejecutar con sudo"; exit 1; }

probar() {
    local usuario=$1 accion=$2
    shift 2
    if sudo -u "$usuario" "$@" &>/dev/null; then r=OK; else r=DENEGADO; fi
    printf "%-6s %-22s %s\n" "$usuario" "$accion" "$r"
}

for u in eli iri; do
    probar "$u" "leer app.conf"      cat /srv/proyecto/app.conf
    probar "$u" "modificar app.conf" sh -c 'echo x >> /srv/proyecto/app.conf'
    probar "$u" "ejecutar deploy.sh" /srv/proyecto/deploy.sh
    probar "$u" "crear archivo"      touch "/srv/proyecto/prueba-$u.txt"
done

echo
ls -l /srv/proyecto
