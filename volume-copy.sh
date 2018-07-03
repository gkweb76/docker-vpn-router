#!/bin/bash
function get_volume_path {
        volume=`docker volume ls | egrep $1$ | cut -d ' ' -f16`
        volume_path=`docker volume inspect $volume | grep Mount | cut -d'"' -f4`
        echo $volume_path
}

function set_permissions {
        if [ -z "$2" ]; then # permission not passed to function
                mode=644 # set to default chmod 644
        else
                mode=$2
        fi
        chown root:root $1
        chmod $mode $1
        ls -alh $1
}

echo "[*] Finding volume path"
dhcp_volume_path=$(get_volume_path dhcp)
dhcp_leases_volume_path=$(get_volume_path dhcp_leases)
unbound_volume_path=$(get_volume_path unbound)
openvpn_volume_path=$(get_volume_path openvpn)

echo "dhcp_volume_path = $dhcp_volume_path"
echo "dhcp_leases_volume_path = $dhcp_leases_volume_path"
echo "unbound_volume_path = $unbound_volume_path"
echo "openvpn_volume_path = $openvpn_volume_path"

echo ""
echo "[*] Copying files to volumes & setting permissions"
cp ./dhcpd.conf $dhcp_volume_path/
cp ./unbound.conf $unbound_volume_path/
cp ./openvpn.conf $openvpn_volume_path/
cp ./auth.conf $openvpn_volume_path/
cp ./init.sh $openvpn_volume_path/
touch $dhcp_leases_volume_path/dhcpd.leases

# default permission to 644
set_permissions $dhcp_volume_path/dhcpd.conf
set_permissions $unbound_volume_path/unbound.conf
set_permissions $openvpn_volume_path/openvpn.conf
set_permissions $openvpn_volume_path/auth.conf
set_permissions $openvpn_volume_path/init.sh 755

echo ""
echo "[*] Done"
