#!/bin/bash

yum -y update

sed 's/SELINX=enforcing/SELINX=disabled/g' /etc/selinux/config > /etc/selinux/config