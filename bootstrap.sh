#!/bin/bash

yum -y update

sed 's/SELINX=enforcing/SELINUX=disabled/g' /etc/selinux/config > /etc/selinux/config2
