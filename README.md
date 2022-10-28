# Laporan Resmi Praktikum Modul 2 Jarkom Kelompok D06
Dokumen laporan resmi praktikum modul 2 Jarkom Kelompok D06 Jaringan Komputer D Tahun 2022/2023

### Anggota Kelompok:
Nama Lengkap                | NRP
--------------------------- | -------------
Fian Awamiry Maulana        | 5025201035 
Rere Arga Dewanata          | 5025201078 
Muhamad Ridho Pratama       | 5025201186

## Daftar Isi  
- [Soal1](#soal-1)
- [Soal2](#soal-2)
- [Soal3](#soal-3)
- [Soal4](#soal-4)
- [Soal5](#soal-5)
- [Soal6](#soal-6)
- [Soal7](#soal-7)
- [Soal8](#soal-8)
- [Soal9](#soal-9)
- [Soal10](#soal-10)
- [Soal11](#soal-11)
- [Soal12](#soal-12)
- [Soal13](#soal-13)
- [Soal14](#soal-14)
- [Soal15](#soal-15)
- [Soal16](#soal-16)
- [Soal17](#soal-17)
- [Kendala](#kendala)

## Soal 1   
   WISE akan dijadikan sebagai DNS Master, Berlint akan dijadikan DNS Slave, dan Eden akan digunakan sebagai Web Server. Terdapat 2 Client yaitu SSS, dan Garden. Semua node terhubung pada router Ostania, sehingga dapat mengakses internet.  
   
   **Jawaban Soal 1**  
   
   1. Klik ```servers``` di kiri atas.
   2. Klik ```local```.
   3. Klik ```Add blank project```.
   4. Masukkan nama ```project``` yang diinginkan.
   5. Klik ```Add project```.
   6. Klik tombol `Add a node` di samping kiri.
   7. Lalu tarik `ubuntu-1` ke area kosong di halaman.
   8. Tunggu hingga proses loading selesai.
   9. Jika berhasil, maka akan menampilkan tampilan seperti berikut : <br>
![image](https://user-images.githubusercontent.com/72689610/139519228-16e8c278-119a-4ce7-8ad9-5e7be93f418d.png)  
   10. Dibawah ini merupakan topologi dari soal modul 2:  
   {Picture topologi}
   11. Kita perlu melakukan setting network pada masing-masing node dengan fitur `Edit network configuration`, untuk konfigurasi network pada masing - masing node diisi dengan setting sebagai berikut :
   - Ostania
   ```
   auto eth0
   iface eth0 inet dhcp

   auto eth1
   iface eth1 inet static
      address 10.18.1.1
      netmask 255.255.255.0

   auto eth2
   iface eth2 inet static
      address 10.18.2.1
      netmask 255.255.255.0
      
   auto eth3
   iface eth2 inet static
      address 10.18.3.1
      netmask 255.255.255.0
   ```
   - SSS
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.1.2
      netmask 255.255.255.0
      gateway 10.18.1.1
   ```
   - Garden
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.1.3
      netmask 255.255.255.0
      gateway 10.18.1.1
   ```
   - Wise
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.2.2
      netmask 255.255.255.0
      gateway 10.18.2.1
   ```
   - Berlint
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.3.2
      netmask 255.255.255.0
      gateway 10.18.3.1
   ```
   - Eden
   ```
   auto eth0
   iface eth0 inet static
      address 10.18.3.3
      netmask 255.255.255.0
      gateway 10.18.3.1
  ```  
   12. Restart semua node.  
   13. Topologi sudah bisa berjalan secara lokal, namun untuk mengakses jaringan keluar maka perlu dilakukan beberapa konfigurasi sebagai berikut :
   - Ketikkan `vim .bashrc` pada router `Ostania` dan masukkan command berikut :
   ```
   iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.173.0.0/16
   ```
- Ketikkan command `cat /etc/resolv.conf` di `Ostania` kemudian isi dengan nameserver yang sesuai
   ```
   nameserver 192.168.122.1
   ```
- Pada node Wise, SSS, Garden,dan Eden. Ketikkan command `service .bashrc` kemudian masukkan command berikut : 
   ```
   echo nameserver 192.168.122.1 > /etc/resolv.conf
   ```
 - Restart kembali semua node dan semua node sekarang sudah bisa melakukan ping ke ww.google.com, yang artinya topologi sudah bisa mengakses jaringan keluar. <br>
   {Picture ketika ping google.com}
## Soal 2   
   Untuk mempermudah mendapatkan informasi mengenai misi dari Handler, bantulah Loid membuat website utama dengan akses wise.yyy.com dengan alias www.wise.yyy.com pada folder wise.  

   **Jawaban Soal 2**  
1. Buka WebConsole `Wise`, dan `Berlint`. Ketikkan `service .bashrc` dan masukkan command berikut
  ```
  apt-get update
  apt-get install bind9 -y
  ```
2. Buka WebConsole `SSS` ,dan `Garden`. Ketikkan `service .bashrc` dan masukkan command berikut
 ```
 apt-get update
 apt-get install dnsutils -y
 ```
3. Restart semua node.
4. Masukkan command berikut pada `Wise`
  ```
 nano /etc/bind/named.conf.local
  ```
5. Isikan configurasi zone domain **wise.d06.com** sesuai dengan syntax berikut:
  ```
  zone "wise.d06.com" {
	type master;
	file "/etc/bind/wise/wise.d06.com";
};
  ```
6. Buat folder **wise** di dalam /etc/bind
  ```
  mkdir /etc/bind/wise
  ```
7. Copy file `db.local` pada path `/etc/bind` ke dalam folder **wise** yang baru saja dibuat dan ubah namanya menjadi `wise.d06.com`
  ```
  cp /etc/bind/db.local /etc/bind/wise/wise.d06.com
  ```
8. Buka file **wise.d06.com** dan edit seperti gambar berikut dengan IP 10.18.2.2 dan IP 10.18.3.3 serta record CNAME `www` <br>
   {Picture dalam file wise.d06.com}  
9. Restart bind9 dengan command `service bind9 restart`
10. Comment nameserver `Ostania` pada `etc/resolv.conf` di node `SSS` dan `Garden` kemudian tambahkan `nameserver 10.18.2.2` <br>
   {Picture dalam file etc/resolv.conf di SS & Garden}  
12. Kemudian test dengan cara ping IP `wise.d06.com` dan `wise.d06.com` pada `SSS` atau `Garden` <br>
   {Picture dalam ping wise.d06.com/www.wise.d06.com di SSS & Garden}  
## Soal 3  
   Setelah itu ia juga ingin membuat subdomain eden.wise.yyy.com dengan alias www.eden.wise.yyy.com yang diatur DNS-nya di WISE dan mengarah ke Eden.  
   
   **Jawaban Soal 3**  
   1. Jalankan command `nano /etc/bind/kaizoku/wise.d06.com` dan masukkan data seperti gambar berikut untuk membuat subdomain dan aliasnya <br>
  {Picture didalam wise file wise.d06.com}  
  2. Restart bind9 dengan menggunakan command `service bind9 restart`
  3. Kemudian test dengan cara ping IP `eden.wise.d06.com` dan `www.eden.wise.d06.com` pada `Loguetown` atau `Alabasta` <br>
   {Picture ketika ping di SSS eden.wise.d06.com}  
   {Picture ketika ping di SSS www.eden.wise.d06.com}  
## Soal 4   
   Buat juga reverse domain untuk domain utama.  
   
   **Jawaban Soal 4**  
   1. Jalankan command `nano /etc/bind/named.conf.local` pada `Wise`
   2. Lalu tambahkan konfigurasi berikut ke dalam file `named.conf.local` dibawah zone `wise.d06.com`. Tambahkan reverse IP `10.18.2` yaitu `10.18.2`. 
 ```
 zone "2.18.10.in-addr.arpa" {
    type master;
    file "/etc/bind/wise/2.18.10.in-addr.arpa";
};
 ```  
	{Picture didalam wise file named.conf.local}  
   3. Copykan file `db.local` pada path `/etc/bind` ke dalam folder **wise** yang baru saja dibuat dan ubah namanya menjadi `2.18.10.in-addr.arpa`  
   4. Edit file `2.18.10.in-addr.arpaa` menggunakan command `nano/etc/bind/wise/2.18.10.in-addr.arpa` menjadi seperti gambar di bawah ini <br>    {Picture didalam wise file named.conf.local} 
   5. Restart bind9 dengan command `service bind9 restart`
   6. Test dengan cara mengetikkan command `host -t PTR "10.18.2.2"` pada `SSS`. Jika muncul seperti pada gambar berikut berarti sudah benar. <br>  
      {Picture PING host -t PTR 10.18.2.2 di SSS} 
## Soal 5   
   Agar dapat tetap dihubungi jika server WISE bermasalah, buatlah juga Berlint sebagai DNS Slave untuk domain utama.  
   
   **Jawaban Soal 5**  
   1. Edit file `/etc/bind/named.conf.local` pada `Wise` tepatnya pada zone `franky.A09.com` dan sesuaikan dengan syntax berikut
 ```
 zone "wise.d06.com" {
        type master;
        notify yes;
        also-notify { 10.18.3.2; };
        allow-transfer { 10.18.3.2; };
        file "/etc/bind/wise/wise.d06.com";
};
 ```
	{Picture didalam wise named.conf.local}  
   2. Restart bind9 `Wise` dengan command `service bind9 restart`
   3. Kemudian buka file `/etc/bind/named.conf.local` pada `Berlint` dan tambahkan syntax berikut:
	 ```
	 zone "wise.d06.com" {
	    type slave;
	    masters { 10.18.2.2; };
	    file "/var/lib/bind/wise.d06.com";
	};
	 ```
	{Picture didalam berlint file named.conf.local}
   4. Restart bind9 `Berlint` dengan command `service bind9 restart`
   5. Test dengan cara mematikan bind9 pada `Wise` yaitu dengan mengetikkan comman `service bind9 stop`
   6. Di node `SSS` dan `Garden` tambahkan `nameserver 10.18.3.2`.
   7. Lalu ping ke semua domain atau subdomain yang telah dibuat.  
   {Picture ping domain atau subdomain}
## Soal 6   
   Karena banyak informasi dari Handler, buatlah subdomain yang khusus untuk operation yaitu operation.wise.yyy.com dengan alias www.operation.wise.yyy.com yang didelegasikan dari WISE ke Berlint dengan IP menuju ke Eden dalam folder operation.  
      
   **Jawaban Soal 6**  
   1. Pada `Wise`, edit file `/etc/bind/wise/wise.d06.com` dan ubah menjadi seperti di bawah ini. <br>
   {Picture pada wise file wise.d06.com}
   2. Kemudian edit file `/etc/bind/named.conf.options` pada `Wise`, comment `dnssec-validation auto;` dan tambahkan `allow-query{any;};` <br>
   {Picture pada wise file named.conf.options}
   3. Restart bind9 `Wise` dengan command `service bind9 restart`
   4. Lakukan langkah kedua pada `Berlint`
   5. Lalu edit file `/etc/bind/named.conf.local` pada `Berlint` tambahkan syntax berikut:
 ```
 zone "operation.wise.d06.com" {
        type master;
        file "/etc/bind/wise/operation.wise.d06.com";
};
 ```
	{Picture didalam berlint file named.conf.local}
   6. Kemudian buatlah folder `wise` pada `Berlint` dengan mengetikkan command `mkdir /etc/bind/operation`
   7. Dan ketikkan command `cp /etc/bind/db.local /etc/bind/operation/operation.wise.d06.com` pada `Berlint`
   8. Kemudian edit file `operation.wise.d06.com` pada `Berlint` menjadi seperti dibawah ini <br>
      {Picture pada berlint file operation.wise.d06.com}
   9. Restart bind9 `Berlint` dengan command `service bind9 restart`
   10. Kemudian test dengan cara ping IP `operation.wise.d06.com` dan `www.operation.wise.d06.com` pada `SSS` atau `Garden` <br>
      {Picture ping pada SSS & Garden operation.wise.d06.com}  
      {Picture ping pada SSS & Garden www.operation.wise.d06.com}
## Soal 7   
   Untuk informasi yang lebih spesifik mengenai Operation Strix, buatlah subdomain melalui Berlint dengan akses strix.operation.wise.yyy.com dengan alias www.strix.operation.wise.yyy.com yang mengarah ke Eden.  
      
   **Jawaban Soal 7**  
   1. Jalankan command `nano /etc/bind/wise/operation.wise.d06.com` pada `Berlint` dan edit seperti gambar berikut untuk membuat subdomain dan aliasnya <br>
   {Picture didalam berlint file operation.wise.d06.com}  
   2. Restart bind9 `Berlint` dengan command `service bind9 restart`
   3. Kemudian test dengan cara ping IP `strix.operation.wise.d06.com` dan `www.strix.operation.wise.d06.com` pada `SSS` atau `Garden` <br>
    {Picture ping di SSS dan garden strix.operation.wise.d06.com}  
    {Picture ping di SSS dan garden www.strix.operation.wise.d06.com}  
## Soal 8   
   Setelah melakukan konfigurasi server, maka dilakukan konfigurasi Webserver. Pertama dengan webserver www.wise.yyy.com. Pertama, Loid membutuhkan webserver dengan DocumentRoot pada /var/www/wise.yyy.com.
    
   **Jawaban Soal 8**  
   Pada Node EDEN, lakukan langkah berikut:
   1. Copy file /etc/apache2/sites-available/000-default.conf ke /etc/apache2/sites-available/wise.d06.com.conf dengan command
      ```
      	cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/wise.d06.com.conf 
      ```
   2. Edit file wise.d06.com.conf menjadi 
      ```
	<VirtualHost *:80>
		ServerAdmin webmaster@localhost
		DocumentRoot /var/www/wise.d06.com
		ServerName www.wise.d06.com
		ServerAlias www.wise.d06.com wise.d06.com
		
		ErrorLog ${APACHE_LOG_DIR}/error.log
		CustomLog ${APACHE_LOG_DIR}/access.log combined
	</VirtualHost>
      ```
   3. Mengaktifkan konfigurasi yang telah dibuat dengan command
      ```
      a2ensite wise.d06.com
      ```
   4. Download semua resource soal dan letakkan pada /var/www/eden.wise.d06.com
   5. Ketika Mengakses url www.wise.d06.com dengan lynx maka akan didapatkan hasil berikut.  
      -- {Gambar akses www.wise.d06.com dari klien} --
## Soal 9   
   Setelah itu, Loid juga membutuhkan agar url www.wise.yyy.com/index.php/home dapat menjadi menjadi www.wise.yyy.com/home.  
      
   **Jawaban Soal 9** 
   1. Edit file wise.d06.com.conf menjadi 
      ```
      <VirtualHost *:80>
         ServerAdmin webmaster@localhost
         DocumentRoot /var/www/wise.d06.com
         ServerName www.wise.d06.com
         ServerAlias www.wise.d06.com wise.d06.com

         <Directory /var/www/wise.d06.com.conf>
            Options +FollowSymLinks -Multiviews
            AllowOverride All
         </Directory>
         
         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined
	   </VirtualHost>

      ```  
   2. Buat file .htaccess pada direktori /var/www/wise.d06.com lalu isikan dengan
      ```
      RewriteEngine On
      RewriteCond %{REQUEST_FILENAME} !-d
      RewriteRule ^([^\.]+)$ $1.php [NC,L]

      RewriteBase /
      RewriteCond %{HTTP_HOST} ^10\.18\.3\.3$
      RewriteRule ^(.*)$ http://www.wise.d06.com/$1 [L,R=301]
      ```    
   2. Restart apache2 dengan cara `service apache2 restart` 
   3. Ketika Mengakses url www.wise.d06.com/home dengan lynx maka akan didapatkan hasil berikut.  
      -- {Gambar akses www.wise.d06.com/home dari klien} --   
## Soal 10   
   Setelah itu, pada subdomain www.eden.wise.yyy.com, Loid membutuhkan penyimpanan aset yang memiliki DocumentRoot pada /var/www/eden.wise.yyy.com.  
      
   **Jawaban Soal 10** 
   1. Mengedit file eden.wise.d06.com.conf menjadi seperti ini
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      <Directory /var/www/eden.wise.d06.com/public>
         Options +Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/error>
         Options -Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/public/js>
         Options +Indexes
      </Directory>

      Alias "/js" "/var/www/eden.wise.d06.com/public/js"

      ErrorDocument 404 /error/404.html

      <Directory /var/www/eden.wise.d06.com/public/images>
         AllowOverride All
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   2. Restart apache dengan cara `service apache2 restart`
   3. Ketika Mengakses url www.eden.wise.d06.comdengan lynx maka akan didapatkan hasil berikut.  
      -- {Gambar akses www.eden.wise.d06.com dari klien} --
## Soal 11   
   Akan tetapi, pada folder /public, Loid ingin hanya dapat melakukan directory listing saja.  
      
   **Jawaban Soal 11** 
   1. Mengedit file eden.wise.d06.com.conf dengan menambahkan Options + Indexes menjadi seperti ini
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      <Directory /var/www/eden.wise.d06.com/public>
         Options +Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/error>
         Options -Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/public/js>
         Options +Indexes
      </Directory>

      Alias "/js" "/var/www/eden.wise.d06.com/public/js"

      ErrorDocument 404 /error/404.html

      <Directory /var/www/eden.wise.d06.com/public/images>
         AllowOverride All
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   2. Restart apache dengan cara `service apache2 restart`
   3. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/public dengan lynx.  
      -- {Gambar akses www.eden.wise.d06.com/public dari klien} -- 
## Soal 12   
   Tidak hanya itu, Loid juga ingin menyiapkan error file 404.html pada folder /error untuk mengganti error kode pada apache.  
      
   **Jawaban Soal 12** 
   1. Mengedit file eden.wise.d06.com.conf dengan menambahkan ErrorDocument 404 /error/404.html menjadi seperti ini  

      ```
      <VirtualHost *:80>
         ServerAdmin webmaster@localhost
         DocumentRoot /var/www/eden.wise.d06.com
         ServerName www.eden.wise.d06.com
         ServerAlias www.eden.wise.d06.com eden.wise.d06.com

         <Directory /var/www/eden.wise.d06.com/public>
            Options +Indexes
         </Directory>

         <Directory /var/www/eden.wise.d06.com/error>
            Options -Indexes
         </Directory>

         <Directory /var/www/eden.wise.d06.com/public/js>
            Options +Indexes
         </Directory>

         Alias "/js" "/var/www/eden.wise.d06.com/public/js"

         ErrorDocument 404 /error/404.html

         <Directory /var/www/eden.wise.d06.com/public/images>
            AllowOverride All
         </Directory>

         ErrorLog ${APACHE_LOG_DIR}/error.log
         CustomLog ${APACHE_LOG_DIR}/access.log combined
      </VirtualHost>
      ```
   2. Restart apache dengan cara `service apache2 restart`
   3. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/cek dengan lynx.  
      -- {Gambar akses www.eden.wise.d06.com/cek dari klien} --
      
## Soal 13   
   Loid juga meminta Franky untuk dibuatkan konfigurasi virtual host. Virtual host ini bertujuan untuk dapat mengakses file asset www.eden.wise.yyy.com/public/js menjadi www.eden.wise.yyy.com/js (13).  
      
   **Jawaban Soal 13**  
   1. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/public/js dengan lynx.  
      -- {Gambar akses www.eden.wise.d06.com/public/js dari klien} --
   2. Mengedit file eden.wise.d06.com.conf dengan menambahkan Alias "/js" "/var/www/eden.wise.d06.com/public/js" menjadi seperti ini
   ```
   <VirtualHost *:80>
      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/eden.wise.d06.com
      ServerName www.eden.wise.d06.com
      ServerAlias www.eden.wise.d06.com eden.wise.d06.com

      <Directory /var/www/eden.wise.d06.com/public>
         Options +Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/error>
         Options -Indexes
      </Directory>

      <Directory /var/www/eden.wise.d06.com/public/js>
         Options +Indexes
      </Directory>

      Alias "/js" "/var/www/eden.wise.d06.com/public/js"

      ErrorDocument 404 /error/404.html

      <Directory /var/www/eden.wise.d06.com/public/images>
         AllowOverride All
      </Directory>

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
   </VirtualHost>
   ```
   3. Restart apache dengan cara `service apache2 restart`
   4. Berikut adalah tampilan ketika mengakses url www.eden.wise.d06.com/js dengan lynx.  
      -- {Gambar akses www.eden.wise.d06.com/js dari klien} --
## Soal 14   
   Loid meminta agar www.strix.operation.wise.yyy.com hanya bisa diakses dengan port 15000 dan port 15500.  
      
   **Jawaban Soal 14** 
   1. Mengedit file strix.operation.wise.d06.com.conf dengan menambahkan Listen 15000 dan Listen 15500 menjadi seperti ini  

   ```
      <VirtualHost *:15000 *:15500>

      ServerAdmin webmaster@localhost
      DocumentRoot /var/www/strix.operation.wise.d06
      ServerName www.strix.operation.wise.d06.com
      ServerAlias www.strix.operation.wise.d06.com strix.operation.wise.d06.com

      <Directory /var/www/strix.operation.wise.d06>
         AuthType Basic
         AuthName "Restricted Content"
         AuthUserFile /etc/apache2/.htpasswd
         Require valid-user
      </Directory>	

      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined

      </VirtualHost>
   ```
   2. Menambahkan port pada /etc/apache2/ports.conf menjadi seperti ini
   ```
   Listen 80
   Listen 15000
   Listen 15500

   <IfModule ssl_module>
      Listen 443
   </IfModule>

   <IfModule mod_gnutls.c>
      Listen 443
   </IfModule>
   ```
   3. Restart apache dengan cara `service apache2 restart`
   4. Berikut adalah tampilan ketika mengakses url www.strix.operation.wise.d06.com:15000 dengan lynx.  
      -- {Gambar akses www.strix.operation.wise.d06.com:15000 dari klien} --
   5. Berikut adalah tampilan ketika mengakses url www.strix.operation.wise.d06.com:15500 dengan lynx.  
      -- {Gambar akses www.strix.operation.wise.d06.com:15500 dari klien} --
   

## Soal 15   
   Dengan autentikasi username Twilight dan password opStrix dan file di /var/www/strix.operation.wise.yyy (15).  
      
   **Jawaban Soal 15** 
## Soal 16   
   Dan setiap kali mengakses IP Eden akan dialihkan secara otomatis ke www.wise.yyy.com (16).  
      
   **Jawaban Soal 16** 
## Soal 17   
   Karena website www.eden.wise.yyy.com semakin banyak pengunjung dan banyak modifikasi sehingga banyak gambar-gambar yang random, maka Loid ingin mengubah request gambar yang memiliki substring “eden” akan diarahkan menuju eden.png. Bantulah Agent Twilight dan Organisasi WISE menjaga perdamaian! (17).   
      
   **Jawaban Soal 17** 
