#!/bin/bash

echo "------------------------"

#yum -y update

# sed 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config > /etc/selinux/config_tmp
# sed 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config_tmp > /etc/selinux/config
# rm -f /etc/selinux/config_tmp
#
# setenforce 0

hostname="$(hostname)"

if [ ! -f "$hostname.config" ]; then
	echo "No bootstrap config"
	exit 1
fi

for network in $(nmcli con | tail -n +2 | cut -d' ' -f1); do
	echo "config for network $network"

	check="$(crudini --get $hostname.config $network)"
	[ "$check" = "" ] && continue

	static_ip=$(crudini --get $hostname.config $network static_ip)
	gateway=$(crudini --get $hostname.config $network gateway)
	dns=$(crudini --get $hostname.config $network dns)

	echo "setting ip"
	nmcli con mod $network ipv4.addresses $static_ip/24
	echo "setting gateway"
	nmcli con mod $network ipv4.gateway $gateway
	echo "setting dns"
	nmcli con mod $network ipv4.dns $dns
	echo "setting manual"
	nmcli con mod $network ipv4.method manual
	echo "setting autoconnect"
	nmcli con mod $network connection.autoconnect yes
done

exit 0
