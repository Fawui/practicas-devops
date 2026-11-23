#!/usr/bin/env bash
# red.sh - Diagnostico basico de red

SITIOS=(google.com github.com sitio-que-no-existe.xyz)

echo "===== Diagnostico de red: $(date '+%Y-%m-%d %H:%M:%S') ====="

echo
echo "== 1. Mi IP"
hostname -I

echo
echo "== 2. Puerta de enlace (router)"
ip route | grep default

echo
echo "== 3. Servidores DNS"
grep nameserver /etc/resolv.conf

echo
echo "== 4. DNS: nombre -> IP"
for s in "${SITIOS[@]}"; do
    ip=$(getent ahostsv4 "$s" | awk 'NR == 1 { print $1 }')
    echo "  $s -> ${ip:-NO RESUELVE}"
done

echo
echo "== 5. Ping a 8.8.8.8"
ping -c 3 -q 8.8.8.8 | tail -2

echo
echo "== 6. Puertos abiertos en esta maquina"
ss -tln

echo
echo "== 7. Respuesta HTTP"
for s in "${SITIOS[@]}"; do
    r=$(curl -s -o /dev/null -w '%{http_code} en %{time_total}s' --max-time 5 "https://$s")
    echo "  $s -> HTTP $r"
done
