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

static_ip=$(crudini --get $hostname.config general static_ip)
gateway=$(crudini --get $hostname.config general gateway)
dns=$(crudini --get $hostname.config general dns)

nmcli con mod enp0s3 ipv4.addresses $static_ip/24
nmcli con mod enp0s3 ipv4.gateway $gateway
nmcli con mod enp0s3 ipv4.dns $dns
nmcli con mod enp0s3 ipv4.method manual
nmcli con mod enp0s3 connection.autoconnect yes

exit 0
