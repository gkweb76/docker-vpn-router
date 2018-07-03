#!bin/ash
iptables -t nat -D POSTROUTING -o tun0 -j MASQUERADE
ip route del 10.0.0.0/24 via 172.27.100.1 dev eth0

iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
ip route add 10.0.0.0/24 via 172.27.100.1 dev eth0
