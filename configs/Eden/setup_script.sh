#!/bin/bash

echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install apache2 php libapache2-mod-php7.0 -y

service apache2 start

cp /root/wise.d06.com.conf /etc/apache2/sites-available
mkdir /var/www/wise.d06.com
cp /root/resource/wise/* /var/www/wise.d06.com
cp /root/htaccesses/var-www-wise.d06.com/.htaccess /var/www/wise.d06.com

# Soal no. 10 - 13
# Ubah DocumentRoot, directory listing, page error 404, dan alias untuk js
cp /root/eden.wise.d06.com.conf /etc/apache2/sites-available
mkdir /var/www/eden.wise.d06.com
cp -r /root/resource/eden.wise/. /var/www/eden.wise.d06.com 
# ------------------------------------------------------------------

# Soal no. 14 - 15
# Setup strix.operation.wise agar hanya bisa diakses port 15000 dan 15500
# Serta membuat autentikasi saat mengakses server tersebut
cp /root/strix.operation.wise.d06.com.conf /etc/apache2/sites-available
cp /root/.htpasswd /etc/apache2
mkdir /var/www/strix.operation.wise.d06
cp /root/resource/strix.operation.wise/* /var/www/strix.operation.wise.d06
cp /root/ports.conf /etc/apache2
# ------------------------------------------------------------

# Soal no. 16
# Buat redirect IP dari 10.18.3.3 ke www.wise.eden.d06.com
cp /root/apache2.conf /etc/apache2/
mkdir /var/www/html
cp /root/htaccesses/var-www-html/.htaccess /var/www/html
# -----------------------------------------------------

a2enmod rewrite
a2dissite 000-default
a2ensite wise.d06.com
a2ensite eden.wise.d06.com
a2ensite strix.operation.wise.d06.com
service apache2 restart
