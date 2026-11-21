#!/usr/bin/env bash
# setup.sh - Crea grupo, usuarios y carpeta compartida con permisos
set -e
[ "$EUID" -eq 0 ] || { echo "Ejecutar con sudo"; exit 1; }

groupadd -f devops
id eli &>/dev/null || useradd -m -s /bin/bash -G devops eli
id iri &>/dev/null || useradd -m -s /bin/bash iri

mkdir -p /srv/proyecto
chown root:devops /srv/proyecto
chmod 2770 /srv/proyecto

echo "entorno=dev" > /srv/proyecto/app.conf
chown root:devops /srv/proyecto/app.conf
chmod 640 /srv/proyecto/app.conf

printf '#!/bin/bash\necho "deploy ejecutado por $(whoami)"\n' > /srv/proyecto/deploy.sh
chown root:devops /srv/proyecto/deploy.sh
chmod 750 /srv/proyecto/deploy.sh

ls -la /srv/proyecto
