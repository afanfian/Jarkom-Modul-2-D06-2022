#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

cp /root/named.conf.options /etc/bind
cp /root/named.conf.local /etc/bind

mkdir /etc/bind/operation
cp /root/operation.wise.d06.com /etc/bind/operation

service bind9 restart
