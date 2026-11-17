#!/bin/bash

# Determinar si el usuario ejecuta este script como root o no.

# Mostramos ID de usuario
echo "Tu ID de usuario es ${UID}"

# Mostramos si el usuario es root o no
if [[ "${UID}" -eq 0 ]]
then
 echo "Sos root"
else
 echo "No sos root"
fi

