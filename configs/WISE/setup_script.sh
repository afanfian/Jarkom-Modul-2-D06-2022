#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

cp /root/named.conf.local /etc/bind
cp /root/named.conf.options /etc/bind

mkdir /etc/bind/wise
cp /root/wise.d06.com /etc/bind/wise
cp /root/2.18.10.in-addr.arpa /etc/bind/wise

service bind9 restart
