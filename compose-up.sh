#!/bin/bash
echo "[*] Deploying containers"
docker-compose -f compose-vpn.yml -p gkweb76 up --detach

echo "[*] Reloading iptables"
/etc/init.d/firewall

echo ""
docker container ls
