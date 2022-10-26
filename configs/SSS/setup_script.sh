#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install dnsutils lynx wget curl -y

echo '
nameserver 10.18.2.2 # IP WISE
nameserver 10.18.3.2 # IP Berlint' > /etc/resolv.conf
