#!/bin/bash

yum -y update

sed 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config > /etc/selinux/config_tmp
sed 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config_tmp > /etc/selinux/config
rm -f /etc/selinux/config_tmp
