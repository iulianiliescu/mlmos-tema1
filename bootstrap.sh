#!/bin/bash

yum -y update

sed 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config > /etc/selinux/config2
sed 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config2 > /etc/selinux/config
